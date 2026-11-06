"""The game's own textures for the windows' editor: found in its folder or its
MPQ archives (the newest patch first), made PNGs in tools/art/game/ the first
time (delete that folder to make them again). Needs Pillow."""
import bz2
import glob
import io
import os
import struct
import zlib

from PIL import Image

GAME = os.path.normpath(os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "..", ".."))
CACHE = os.path.join(os.path.dirname(os.path.abspath(__file__)), "art", "game")
EXTENSIONS = ("", ".blp", ".tga")


def crypt_table():
    table, seed = [0] * 0x500, 0x00100001
    for i in range(0x100):
        at = i
        for _ in range(5):
            seed = (seed * 125 + 3) % 0x2AAAAB
            high = (seed & 0xFFFF) << 16
            seed = (seed * 125 + 3) % 0x2AAAAB
            table[at] = high | (seed & 0xFFFF)
            at += 0x100
    return table


CRYPT = crypt_table()


def hash_of(text, kind):
    a, b = 0x7FED7FED, 0xEEEEEEEE
    for byte in text.upper().replace("/", "\\").encode("latin-1", "replace"):
        a = (CRYPT[(kind << 8) + byte] ^ (a + b)) & 0xFFFFFFFF
        b = (byte + a + b + (b << 5) + 3) & 0xFFFFFFFF
    return a


def decrypted(data, key):
    out, seed = [], 0xEEEEEEEE
    for value in struct.unpack("<%dI" % (len(data) // 4), data):
        seed = (seed + CRYPT[0x400 + (key & 0xFF)]) & 0xFFFFFFFF
        value ^= (key + seed) & 0xFFFFFFFF
        out.append(value)
        key = (((~key << 21) + 0x11111111) | (key >> 11)) & 0xFFFFFFFF
        seed = (value + seed + (seed << 5) + 3) & 0xFFFFFFFF
    return out


class Archive:
    """One MPQ, read only: zlib and bzip2, what its textures use."""

    def __init__(self, path):
        self.file = open(path, "rb")
        self.start = 0
        while True:
            self.file.seek(self.start)
            magic = self.file.read(4)
            if magic == b"MPQ\x1a":
                break
            if magic == b"MPQ\x1b":
                self.start += struct.unpack("<I", self.file.read(8)[4:])[0]
            elif len(magic) < 4:
                raise ValueError(path + " is not an MPQ")
            else:
                self.start += 512
        _, _, _, shift, hashes, blocks, self.hash_count, block_count = struct.unpack("<IIHHIIII", self.file.read(28))
        self.sector = 512 << shift
        self.file.seek(self.start + hashes)
        self.hashes = decrypted(self.file.read(self.hash_count * 16), hash_of("(hash table)", 3))
        self.file.seek(self.start + blocks)
        self.blocks = decrypted(self.file.read(block_count * 16), hash_of("(block table)", 3))

    def find(self, name):
        a, b = hash_of(name, 1), hash_of(name, 2)
        start = hash_of(name, 0) & (self.hash_count - 1)
        for i in range(self.hash_count):
            at = ((start + i) & (self.hash_count - 1)) * 4
            block = self.hashes[at + 3]
            if block == 0xFFFFFFFF:
                return None
            if block != 0xFFFFFFFE and self.hashes[at] == a and self.hashes[at + 1] == b:
                return block
        return None

    def read(self, name):
        block = self.find(name)
        if block is None:
            return None
        position, packed, size, flags = self.blocks[block * 4:block * 4 + 4]
        # (unread: encrypted, imploded; a patch's deleted file)
        if not flags & 0x80000000 or flags & 0x02010100:
            return None
        self.file.seek(self.start + position)
        compressed = flags & 0x200
        if flags & 0x01000000:  # (in one piece)
            data = self.file.read(packed)
            return unpacked(data) if compressed and packed < size else data
        count = (size + self.sector - 1) // self.sector
        if not compressed:
            return self.file.read(size)
        data = self.file.read(packed)
        offsets = struct.unpack("<%dI" % (count + 1), data[:(count + 1) * 4])
        out = []
        for i in range(count):
            piece = data[offsets[i]:offsets[i + 1]]
            whole = min(self.sector, size - i * self.sector)
            out.append(piece if len(piece) == whole else unpacked(piece))
        return b"".join(out)


def unpacked(data):
    method, rest = data[0], data[1:]
    if method == 2:
        return zlib.decompress(rest)
    if method == 0x10:
        return bz2.decompress(rest)
    raise ValueError("compression %d" % method)


def archives():
    """The game's archives, the one that wins first (speech has no textures)."""
    data = os.path.join(GAME, "Data")
    locale = [d for d in glob.glob(os.path.join(data, "*")) if os.path.basename(d).lower() in ("enus", "engb", "frfr", "dede", "eses", "ruru")]

    def found(folder):
        names = sorted((os.path.basename(p) for p in glob.glob(os.path.join(folder, "*")) if p.lower().endswith(".mpq")),
                       key=lambda n: n.lower()[:-4])
        return [os.path.join(folder, n) for n in names if "speech" not in n.lower()]

    def is_patch(path):
        return os.path.basename(path).lower().startswith("patch")

    general = found(data)
    local = [p for d in locale for p in found(d)]
    order = [p for p in general if not is_patch(p)] + [p for p in local if not is_patch(p)]
    order += [p for p in general if is_patch(p)] + [p for p in local if is_patch(p)]
    return list(reversed(order))


def on_disk(path):
    """A file in the game's folder (an addon's texture), whatever its case."""
    at = GAME
    for segment in path.split("/"):
        try:
            names = {n.lower(): n for n in os.listdir(at)}
        except OSError:
            return None
        if segment not in names:
            return None
        at = os.path.join(at, names[segment])
    return at if os.path.isfile(at) else None


opened = None


def read(path):
    """A texture's file, from its lowercase path with / and maybe no extension."""
    global opened
    tries = [path + e for e in EXTENSIONS]
    for name in tries:
        found = on_disk(name)
        if found:
            with open(found, "rb") as file:
                return file.read()
    if opened is None:
        opened = [Archive(p) for p in archives()]
    for archive in opened:
        for name in tries:
            data = archive.read(name)
            if data:
                return data
    return None


def png(path):
    """The PNG made of a texture, or None when the game can't give us one
    (a portrait, a character's model...)."""
    out = os.path.join(CACHE, path + ".png")
    if not os.path.exists(out):
        try:
            data = read(path)
            if not data:
                return None
            picture = Image.open(io.BytesIO(data)).convert("RGBA")
            os.makedirs(os.path.dirname(out), exist_ok=True)
            picture.save(out)
        except (OSError, ValueError, zlib.error, EOFError, struct.error) as problem:
            print("Can't read %s: %s" % (path, problem))
            return None
    return out
