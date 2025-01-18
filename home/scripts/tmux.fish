#!/usr/bin/env fish

#nix-build -E 'let pkgs = import <nixpkgs> {}; tokyonight = pkgs.tmuxPlugins.mkTmuxPlugin { pluginName = "tokyonight"; version = "latest"; src = pkgs.fetchFromGitHub { owner = "fabioluciano"; repo = "tmux-tokyo-night"; rev = "main"; sha256 = "sha256-9nDgiJptXIP+Hn9UY+QFMgoghw4HfTJ5TZq0f9KVOFg="; }; }; in tokyonight'
#
#/nix/store/674ar0bcq6ilkc4iyipwb6nh0qy613m0-tmuxplugin-tokyonight-latest

#nix eval nixpkgs#tmuxPlugins.gruvbox.outPath 
#
#"/nix/store/idpp3gwvq2bh1ak6jbap1q9n064122an-tmuxplugin-gruvbox-unstable-2022-04-19"

tmux attach-session
