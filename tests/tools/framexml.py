#!/usr/bin/env python3
# Writes tests/data/framexml.lua: the frames, textures and font strings of
# Blizzard's 3.3.5 windows DiabolicUI restyles, read from Blizzard's own
# FrameXML (their names, types, parents, sizes, first anchor, art and
# text), templates expanded. The fake client (tests/mocks/client_blizzard.lua)
# builds from it whatever it hasn't made by hand.
#
#   tests/tools/framexml.py [path to the 3.3.5 interface files]
#
# (default: ~/Projects/3.3.5-interface-files, Blizzard's FrameXML and
# Blizzard_* addons as extracted from the client)
import os
import sys
import xml.etree.ElementTree as ET

SOURCE = sys.argv[1] if len(sys.argv) > 1 else os.path.expanduser("~/Projects/3.3.5-interface-files")
OUT = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "data", "framexml.lua")

# the windows, by the addon that makes them (nil: always loaded)
ROOTS = {
	None: [
		"MailFrame", "OpenMailFrame", "StackSplitFrame", "MerchantFrame", "FriendsFrame", "SpellBookFrame",
		"QuestLogFrame", "QuestLogDetailFrame", "QuestLogControlPanel", "LFDParentFrame", "LFRParentFrame",
		"BankFrame", "TradeFrame", "TaxiFrame", "ItemTextFrame", "QuestFrame", "GossipFrame", "TabardFrame",
		"PetitionFrame", "GuildRegistrarFrame", "ArenaRegistrarFrame", "PetStableFrame", "DressUpFrame",
		"PVPParentFrame", "BattlefieldFrame", "PetPaperDollFrame", "DropDownList1", "DropDownList2",
		"ReputationFrame", "QuestInfoFrame", "QuestInfoObjectivesFrame", "QuestInfoRewardsFrame",
	],
	"Blizzard_TalentUI": ["PlayerTalentFrame"],
	"Blizzard_GlyphUI": ["GlyphFrame"],
	"Blizzard_InspectUI": ["InspectFrame"],
	"Blizzard_AuctionUI": ["AuctionFrame"],
	"Blizzard_MacroUI": ["MacroFrame", "MacroPopupFrame"],
	"Blizzard_TradeSkillUI": ["TradeSkillFrame"],
	"Blizzard_TrainerUI": ["ClassTrainerFrame"],
	"Blizzard_GuildBankUI": ["GuildBankFrame"],
	"Blizzard_ItemSocketingUI": ["ItemSocketingFrame"],
	"Blizzard_BindingUI": ["KeyBindingFrame"],
	"Blizzard_TokenUI": ["TokenFrame"],
}

FRAMES = {
	"Frame", "Button", "CheckButton", "ScrollFrame", "EditBox", "Slider", "StatusBar", "Model", "PlayerModel",
	"DressUpModel", "TabardModel", "GameTooltip", "MessageFrame", "ScrollingMessageFrame", "SimpleHTML",
	"ColorSelect", "Cooldown", "Minimap", "MovieFrame", "TaxiRouteFrame", "QuestPOIFrame",
}
# the button's own art and text
BUTTON_PARTS = {
	"NormalTexture": "normal", "PushedTexture": "pushed", "DisabledTexture": "disabled",
	"HighlightTexture": "highlight", "CheckedTexture": "checked", "DisabledCheckedTexture": "disabledChecked",
	"ThumbTexture": "thumb", "BarTexture": "bar", "ButtonText": "text",
}


def strip(tag):
	return tag.split("}")[-1]


def load(files):
	"""Every element of `files`, the virtual ones as templates."""
	templates, tops = {}, []
	for path in files:
		root = ET.parse(path).getroot()
		for element in root.iter():
			element.tag = strip(element.tag)
		for element in root:
			if element.get("virtual") == "true" and element.get("name"):
				templates[element.get("name")] = element
			elif element.tag in FRAMES or element.tag in ("Texture", "FontString"):
				tops.append(element)
	return templates, tops


def xml_files(folder, toc):
	files = []
	path = os.path.join(folder, toc)
	for line in open(path, encoding="utf-8", errors="replace"):
		line = line.strip()
		if line.lower().endswith(".xml"):
			files.extend(expand(os.path.join(folder, line.replace("\\", "/"))))
	return files


def expand(path):
	"""An XML file and those it includes, in order."""
	if not os.path.exists(path):
		return []
	files = []
	root = ET.parse(path).getroot()
	for element in root:
		if strip(element.tag) == "Include":
			files.extend(expand(os.path.join(os.path.dirname(path), element.get("file").replace("\\", "/"))))
	files.append(path)
	return files


def size_of(element):
	size = element.find("Size")
	if size is None:
		return None
	x, y = size.get("x"), size.get("y")
	dim = size.find("AbsDimension")
	if dim is not None:
		x, y = dim.get("x", x), dim.get("y", y)
	return (float(x) if x else None, float(y) if y else None)


def anchor_of(element):
	anchors = element.find("Anchors")
	if anchors is None:
		return None
	anchor = anchors.find("Anchor")
	if anchor is None:
		return None
	x, y = anchor.get("x"), anchor.get("y")
	offset = anchor.find("Offset")
	if offset is not None:
		x, y = offset.get("x", x), offset.get("y", y)
		dim = offset.find("AbsDimension")
		if dim is not None:
			x, y = dim.get("x", x), dim.get("y", y)
	point = anchor.get("point")
	return (point, anchor.get("relativeTo"), anchor.get("relativePoint") or point, float(x or 0), float(y or 0))


class Builder:
	def __init__(self, templates):
		self.templates = templates
		self.entries = []

	def add(self, **entry):
		entry["id"] = len(self.entries) + 1
		self.entries.append(entry)
		return entry["id"]

	def name(self, raw, owner):
		if not raw:
			return None
		if "$parent" in raw or "$Parent" in raw:
			return raw.replace("$parent", owner or "").replace("$Parent", owner or "")
		return raw

	def chain(self, element):
		"""`element`'s templates, the deepest first, then itself."""
		out = []
		for template in (element.get("inherits") or "").split(","):
			template = template.strip()
			if template and template in self.templates:
				out.extend(self.chain(self.templates[template]))
		out.append(element)
		return out

	def region(self, element, kind, owner_name, parent_id, layer, role=None):
		name = self.name(element.get("name"), owner_name)
		size, anchor, file, text, hidden = None, None, None, None, None
		for part in self.chain(element):
			size = size_of(part) or size
			anchor = anchor_of(part) or anchor
			file = part.get("file") or file
			text = part.get("text") or text
			hidden = part.get("hidden") or hidden
		if anchor and anchor[1]:
			anchor = (anchor[0], self.name(anchor[1], owner_name), anchor[2], anchor[3], anchor[4])
		self.add(kind=kind, name=name, parent=parent_id, size=size, anchor=anchor, file=file, text=text,
			hidden=hidden == "true", layer=layer, role=role)

	def frame(self, element, parent_id, owner_name):
		chain = self.chain(element)
		name = self.name(element.get("name"), owner_name)
		size, anchor, hidden = None, None, None
		for part in chain:
			size = size_of(part) or size
			anchor = anchor_of(part) or anchor
			hidden = part.get("hidden") or hidden
		if anchor and anchor[1]:
			anchor = (anchor[0], self.name(anchor[1], owner_name), anchor[2], anchor[3], anchor[4])
		frame_id = self.add(kind=element.tag, name=name, parent=parent_id, size=size, anchor=anchor,
			hidden=hidden == "true", text=element.get("text"))
		# `$parent` in what it holds: its name, or its own owner's
		holder = name or owner_name
		for part in chain:
			self.children(part, frame_id, holder)
		return frame_id

	def children(self, element, frame_id, holder):
		for child in element:
			tag = child.tag
			if tag == "Layers":
				for layer in child:
					for region in layer:
						if region.tag in ("Texture", "FontString"):
							self.region(region, region.tag, holder, frame_id, layer.get("level") or "ARTWORK")
			elif tag == "Frames":
				for sub in child:
					if sub.tag in FRAMES:
						self.frame(sub, frame_id, holder)
			elif tag == "ScrollChild":
				for sub in child:
					if sub.tag in FRAMES:
						self.frame(sub, frame_id, holder)
			elif tag in BUTTON_PARTS:
				kind = "FontString" if tag == "ButtonText" else "Texture"
				self.region(child, kind, holder, frame_id, None, BUTTON_PARTS[tag])


def lua(value):
	if value is None:
		return "nil"
	if isinstance(value, bool):
		return "true" if value else "false"
	if isinstance(value, int):
		return str(value)
	if isinstance(value, float):
		return ("%d" % value) if value == int(value) else repr(value)
	if isinstance(value, (tuple, list)):
		return "{ " + ", ".join(lua(v) for v in value) + " }"
	return '"' + str(value).replace("\\", "\\\\").replace('"', '\\"') + '"'


def main():
	base_templates, base_tops = load(xml_files(SOURCE, "FrameXML.toc"))
	out = ["-- Generated by tests/tools/framexml.py from Blizzard's 3.3.5 FrameXML: don't edit.",
		"-- [addon or \"\"] = { { id, kind, name, parent (id or a global's name), { w, h }, { point, relativeTo,",
		"-- relativePoint, x, y }, file, text, hidden, layer, role }, ... }", "return {"]
	for addon, roots in ROOTS.items():
		templates, tops = dict(base_templates), list(base_tops)
		if addon:
			extra_templates, extra_tops = load(xml_files(os.path.join(SOURCE, addon), addon + ".toc"))
			templates.update(extra_templates)
			tops = extra_tops
		builder = Builder(templates)
		by_name = {top.get("name"): top for top in tops}
		for root in roots:
			if root not in by_name:
				print("not found:", addon, root, file=sys.stderr)
		# the roots, and the frames made at the top of a file with one of
		# them (or of those) as their parent ("parent" attribute)
		wanted = set(roots)
		for top in tops:
			if top.get("name") in wanted or top.get("parent") in wanted:
				if top.get("name"):
					wanted.add(top.get("name"))
				builder.frame(top, top.get("parent") or "UIParent", None)
		out.append("\t[%s] = {" % lua(addon or ""))
		for e in builder.entries:
			out.append("\t\t{ %s },"
				% ", ".join(lua(v) for v in (e["id"], e["kind"], e["name"], e["parent"], e["size"], e["anchor"],
					e.get("file"), e.get("text"), e["hidden"], e.get("layer"), e.get("role"))))
		out.append("\t},")
	out.append("}")
	with open(OUT, "w", encoding="utf-8") as f:
		f.write("\n".join(out) + "\n")
	print("wrote", OUT)


main()
