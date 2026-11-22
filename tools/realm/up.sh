#!/usr/bin/env bash
# The test realm: AzerothCore (the core ChromieCraft runs) with playerbots and
# its Lua engine, in podman, on this PC only (127.0.0.1); and the game remote
# (remote.py), a headless test client the checks drive. Run it in your own
# terminal:
#
#   tools/realm/up.sh        builds what's missing (the first time: about an
#                            hour and 15 GB), starts it all, says when it's up
#   tools/realm/up.sh down   stops it all (the realm's database is kept)
#
# Account DUI, password DUI (a game master). Its files: $DIABOLIC_REALM
# (~/Projects/diabolic-realm): the server's source, its settings, the test
# client (links to the game's files, its own WTF) and its Wine prefix.
set -euo pipefail

HERE=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
GAME=$(cd "$HERE/../../../../.." && pwd)
REALM=${DIABOLIC_REALM:-$HOME/Projects/diabolic-realm}
SRC=$REALM/server
DB_PASSWORD=password
NET=dui-realm
say() { printf '\033[1;33m== %s\033[0m\n' "$*"; }

if [ "${1:-}" = down ]; then
	podman rm -f dui-realm-world dui-realm-auth dui-realm-db 2>/dev/null || true
	[ -f "$REALM/remote.pid" ] && kill "$(cat "$REALM/remote.pid")" 2>/dev/null || true
	rm -f "$REALM/remote.pid"
	say "Stopped."
	exit 0
fi

mkdir -p "$REALM"/{etc/modules,logs}

# the source: AzerothCore's playerbot branch, its two modules
if [ ! -d "$SRC/.git" ]; then
	say "Fetching AzerothCore"
	git clone --depth 1 -b Playerbot https://github.com/mod-playerbots/azerothcore-wotlk.git "$SRC"
fi
[ -d "$SRC/modules/mod-playerbots" ] || git clone --depth 1 https://github.com/mod-playerbots/mod-playerbots.git "$SRC/modules/mod-playerbots"
[ -d "$SRC/modules/mod-ale" ] || git clone --depth 1 https://github.com/azerothcore/mod-ale.git "$SRC/modules/mod-ale"

# its settings: the defaults, a few changed (written once: yours to change after)
conf() { # dist, out, then sed expressions
	local dist=$1 out=$2
	shift 2
	[ -f "$out" ] || sed -e "" "$@" "$dist" > "$out"
}
conf "$SRC/src/server/apps/worldserver/worldserver.conf.dist" "$REALM/etc/worldserver.conf" \
	-e 's/^SOAP.Enabled = .*/SOAP.Enabled = 1/' -e 's/^SOAP.IP = .*/SOAP.IP = "0.0.0.0"/' \
	-e 's/^Warden.Enabled = .*/Warden.Enabled = 0/' \
	-e 's/^Instance.IgnoreLevel = .*/Instance.IgnoreLevel = 1/' -e 's/^Instance.IgnoreRaid = .*/Instance.IgnoreRaid = 1/' \
	-e 's/^StartPlayerLevel = .*/StartPlayerLevel = 80/' -e 's/^StartPlayerMoney = .*/StartPlayerMoney = 50000000/' \
	-e 's/^GM.LoginState = .*/GM.LoginState = 1/'
conf "$SRC/src/server/apps/authserver/authserver.conf.dist" "$REALM/etc/authserver.conf"
conf "$SRC/modules/mod-ale/conf/mod_ale.conf.dist" "$REALM/etc/modules/mod_ale.conf" \
	-e 's|^ALE.ScriptPath = .*|ALE.ScriptPath = "/azerothcore/lua_scripts"|'
conf "$SRC/modules/mod-playerbots/conf/playerbots.conf.dist" "$REALM/etc/modules/playerbots.conf" \
	-e "s|^PlayerbotsDatabaseInfo = .*|PlayerbotsDatabaseInfo = \"dui-realm-db;3306;root;$DB_PASSWORD;acore_playerbots\"|" \
	-e 's/^Playerbots.RandomBotAutologin = .*/Playerbots.RandomBotAutologin = 0/' \
	-e 's/^Playerbots.MinRandomBots = .*/Playerbots.MinRandomBots = 0/' \
	-e 's/^Playerbots.MaxRandomBots = .*/Playerbots.MaxRandomBots = 0/'

# the images (each built once; the build stage they share is cached)
for target in db-import worldserver authserver client-data; do
	if ! podman image exists "localhost/dui-realm-$target"; then
		say "Building $target (the first one compiles the server: the long one)"
		podman build -f "$SRC/apps/docker/Dockerfile" --target "$target" -t "dui-realm-$target" \
			--build-arg USER_ID="$(id -u)" --build-arg GROUP_ID="$(id -g)" "$SRC"
	fi
done

podman network exists $NET || podman network create $NET > /dev/null
DBS=(
	-e "AC_LOGIN_DATABASE_INFO=dui-realm-db;3306;root;$DB_PASSWORD;acore_auth"
	-e "AC_WORLD_DATABASE_INFO=dui-realm-db;3306;root;$DB_PASSWORD;acore_world"
	-e "AC_CHARACTER_DATABASE_INFO=dui-realm-db;3306;root;$DB_PASSWORD;acore_characters"
	-e "AC_PLAYERBOTS_DATABASE_INFO=dui-realm-db;3306;root;$DB_PASSWORD;acore_playerbots"
)
FILES=(-v "$REALM/etc:/azerothcore/env/dist/etc" -v "$REALM/logs:/azerothcore/env/dist/logs" --userns=keep-id)

# the database
if ! podman container exists dui-realm-db; then
	podman run -d --name dui-realm-db --network $NET -e MYSQL_ROOT_PASSWORD=$DB_PASSWORD \
		-v dui-realm-db:/var/lib/mysql -p 127.0.0.1:13306:3306 docker.io/library/mysql:8.4 > /dev/null
fi
podman start dui-realm-db > /dev/null
say "Waiting for the database"
until podman exec dui-realm-db mysql -uroot -p$DB_PASSWORD -e "SELECT 1" > /dev/null 2>&1; do sleep 2; done
podman exec dui-realm-db mysql -uroot -p$DB_PASSWORD -e "CREATE DATABASE IF NOT EXISTS acore_playerbots" 2> /dev/null

say "Importing the databases (the first time: a few minutes)"
podman run --rm --network $NET "${DBS[@]}" "${FILES[@]}" dui-realm-db-import
podman exec -i dui-realm-db mysql -uroot -p$DB_PASSWORD acore_auth < "$HERE/account.sql" 2> /dev/null

# the client's data for the server (maps...), downloaded once
if ! podman volume exists dui-realm-data || [ -z "$(podman run --rm -v dui-realm-data:/d docker.io/library/alpine ls /d 2> /dev/null)" ]; then
	say "Downloading the server's map data (1.5 GB)"
	podman run --rm -v dui-realm-data:/azerothcore/env/dist/data dui-realm-client-data
fi

podman rm -f dui-realm-auth dui-realm-world > /dev/null 2>&1 || true
podman run -d --name dui-realm-auth --network $NET "${DBS[@]}" "${FILES[@]}" \
	-p 127.0.0.1:3724:3724 dui-realm-authserver > /dev/null
podman run -d -it --name dui-realm-world --network $NET "${DBS[@]}" "${FILES[@]}" \
	-e AC_DATA_DIR=/azerothcore/env/dist/data -v dui-realm-data:/azerothcore/env/dist/data:ro \
	-v "$HERE/lua:/azerothcore/lua_scripts:ro" \
	-v "$SRC/modules/mod-playerbots/data:/azerothcore/modules/mod-playerbots/data:ro" \
	-p 127.0.0.1:8085:8085 -p 127.0.0.1:7878:7878 dui-realm-worldserver > /dev/null

# the game remote (the test client, headless)
if ! { [ -f "$REALM/remote.pid" ] && kill -0 "$(cat "$REALM/remote.pid")" 2> /dev/null; }; then
	nohup python3 "$HERE/remote.py" "$GAME" "$REALM" > "$REALM/logs/remote.log" 2>&1 &
	echo $! > "$REALM/remote.pid"
fi

say "Waiting for the world server"
until podman logs dui-realm-world 2>&1 | grep -qi "ready\.\.\.\|world initialized"; do
	if ! podman container inspect -f '{{.State.Running}}' dui-realm-world | grep -q true; then
		podman logs --tail 30 dui-realm-world
		say "The world server stopped (its log above)."
		exit 1
	fi
	sleep 5
done
say "Up: realm on 127.0.0.1, the game remote on 127.0.0.1:7999."
