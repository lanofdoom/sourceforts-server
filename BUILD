load("@io_bazel_rules_docker//container:container.bzl", "container_image", "container_layer", "container_push")
load("@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl", "download_pkgs")
load("@io_bazel_rules_docker//docker/package_managers:install_pkgs.bzl", "install_pkgs")
load("@io_bazel_rules_docker//docker/util:run.bzl", "container_run_and_extract")
load("@com_github_lanofdoom_steamcmd//:defs.bzl", "steam_depot_layer")

#
# Source SDK Base 2013 Layer
#

steam_depot_layer(
    name = "sdk",
    app = "244310",
    directory = "/opt/game",
)

#
# SourceForts Layer
#

container_image(
    name = "sourceforts_image",
    base = "@base_image//image",
    directory = "/",
    files = [
        "@sourceforts//file",
    ],
)

container_run_and_extract(
    name = "sourceforts_convert",
    image = ":sourceforts_image.tar",
    commands = [
        "apt update && apt install -y p7zip-full",
        "cd /opt",
        "7z x /sourceforts.7z",
        "tar -czf /sourceforts.tar.gz sfclassic"
    ],
    extract_file = "/sourceforts.tar.gz",
)

container_layer(
    name = "sourceforts",
    directory = "/opt/game",
    tars = [
        ":sourceforts_convert/sourceforts.tar.gz",
    ],
)

#
# MetaMod Layer
#

container_layer(
    name = "metamod",
    directory = "/opt/game/sfclassic",
    tars = [
        "@metamod//file",
    ],
)

#
# SourceMod Layer
#

container_layer(
    name = "sourcemod",
    directory = "/opt/game/sfclassic",
    tars = [
        "@sourcemod//file",
    ],
)

#
# Authorization Layer
#

container_layer(
    name = "authorization",
    directory = "/opt/game/sfclassic",
    tars = [
        "@auth_by_steam_group//file",
    ],
)

#
# Config Layer
#

container_layer(
    name = "config",
    directory = "/opt/game/sfclassic/cfg/templates",
    files = [
        ":server.cfg",
    ],
)

#
# Server Base Image
#

download_pkgs(
    name = "server_deps",
    image_tar = "@base_image//image",
    packages = [
        "ca-certificates",
        "libcurl4",
    ],
)

install_pkgs(
    name = "server_base",
    image_tar = "@base_image//image",
    installables_tar = ":server_deps.tar",
    installation_cleanup_commands = "rm -rf /var/lib/apt/lists/*",
    output_image_name = "server_base",
)

#
# Build Final Image
#

container_image(
    name = "server_image",
    base = ":server_base",
    entrypoint = ["/entrypoint.sh"],
    env = {
        "SF_HOSTNAME": "",
        "SF_MAP": "sf_skywalk",
        "SF_MOTD": "",
        "SF_PASSWORD": "",
        "SF_PORT": "27015",
        "RCON_PASSWORD": "",
        "STEAM_GROUP_ID": "",
        "STEAM_API_KEY": "",
    },
    files = [
        ":entrypoint.sh",
    ],
    layers = [
        ":sdk",
        ":sourceforts",
        ":metamod",
        ":sourcemod",
        ":authorization",
        ":config",
    ],
    symlinks = {
        "/root/.steam/sdk32/steamclient.so": "/opt/game/bin/steamclient.so",
        "/opt/game/bin/materialsystem.so": "/opt/game/bin/materialsystem_srv.so",
        "/opt/game/bin/replay.so": "/opt/game/bin/replay_srv.so",
        "/opt/game/bin/scenefilecache.so": "/opt/game/bin/scenefilecache_srv.so",
        "/opt/game/bin/shaderapiempty.so": "/opt/game/bin/shaderapiempty_srv.so",
        "/opt/game/bin/soundemittersystem.so": "/opt/game/bin/soundemittersystem_srv.so",
        "/opt/game/bin/studiorender.so": "/opt/game/bin/studiorender_srv.so",
        "/opt/game/bin/vphysics.so": "/opt/game/bin/vphysics_srv.so",
    },
)

container_push(
    name = "push_server_image",
    format = "Docker",
    image = ":server_image",
    registry = "ghcr.io",
    repository = "lanofdoom/sourceforts-server",
    tag = "latest",
)