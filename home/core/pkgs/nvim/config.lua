-- Set completeopt for better completion experience
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Copy/Past Clipboard
vim.opt.clipboard = 'unnamedplus'

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Enable 24-bit color
vim.opt.termguicolors = true

-- reloader
function _G.ReloadConfig()
    for name,_ in pairs(package.loaded) do
        if name:match('^user') then
            package.loaded[name] = nil
        end
    end
    dofile(vim.env.HOME .. "/.config/nvim/init.lua")
    vim.notify("Neovim configuration reloaded!", vim.log.levels.INFO)
end

local function run_script_on_start()
  vim.fn.system(vim.env.HOME .. "/.script/nvim.fish")  -- Replace "your-script.sh" with the actual script you want to run
end

vim.api.nvim_create_autocmd("VimEnter", {
  callback = run_script_on_start
})
