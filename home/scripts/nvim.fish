#!/usr/bin/env fish

if test "$argv[1]" = "--tokyonight-dark"
    for server_name in /run/user/1000/nvim.* # maybe should be updated later lol
        nvim --server "$server_name" --remote-send ":lua vim.cmd('colorscheme tokyonight-night')<CR>"
    end
else if test "$argv[1]" = "--gruvbox-light"
    for server_name in /run/user/1000/nvim.* # maybe should be updated later lol
        nvim --server "$server_name" --remote-send ":lua vim.o.background = 'light'<CR>"
        nvim --server "$server_name" --remote-send ":lua vim.cmd('colorscheme gruvbox')<CR>"
    end
end
