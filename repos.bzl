load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def repos(bzlmod = False):
    """Fetches repositories"""

    #
    # Server Dependencies
    #

    http_file(
        name = "auth_by_steam_group",
        downloaded_file_path = "auth_by_steam_group.tar.gz",
        sha256 = "95cb0dd02c46e81594d08edd6456ca2d929b3768235deedf8b8397aa05c1ee1f",
        urls = ["https://github.com/lanofdoom/auth-by-steam-group/releases/download/v2.3.0/auth_by_steam_group.tar.gz"],
    )

    http_file(
        name = "metamod",
        downloaded_file_path = "metamod.tar.gz",
        sha256 = "b7fc903755bb3f273afd797b36e94844b828e721d291d2a7519eecad3fa8486c",
        urls = ["https://mms.alliedmods.net/mmsdrop/1.11/mmsource-1.11.0-git1145-linux.tar.gz"],
    )

    http_file(
        name = "sourceforts",
        downloaded_file_path = "sourceforts.tar.gz",
        sha256 = "3d979831c178c4c70f8106816ae8c1dc4452f5a41a463499230cbc1bcea8a6b9",
        urls = ["https://github.com/lanofdoom/sourceforts-server/releases/download/v1.0-RC7/SFClassic-1.0-RC7-fix.tar.gz"],
    )

    http_file(
        name = "sourcemod",
        downloaded_file_path = "sourcemod.tar.gz",
        sha256 = "9f59ddf32a649695e4c7dac0dfebdc382590486e60ff6473d7b87a31b6bfa01b",
        urls = ["https://sm.alliedmods.net/smdrop/1.10/sourcemod-1.10.0-git6529-linux.tar.gz"],
    )

repos_bzlmod = module_extension(implementation = repos)
