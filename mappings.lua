require('plugins.dap_configs')


-- remove auto comment on next line and other
vim.api.nvim_exec([[
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
]], false)


vim.cmd('filetype plugin on')


map = function(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  for k, v in pairs(opts or {}) do
    options[k] = v
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

python_mappings = function()
  map('n', '<F1>', "<cmd>lua require'dap'.run(LaunchAppConf)<cr>")
  map('n', '<F2>', "<cmd>lua require'dap'.run(LaunchFileConf)<cr>")
  map('n', '<F3>', "<cmd>lua require'dap'.run(DjangoConf)<cr>")
  -- map('n', '<Leader><F4>', "<cmd>lua require'dap'.run(fastapi_conf)<cr>")
  map('n', '<F5>', "<cmd>lua require'dap'.run(LaunchTestConf)<cr>")
end

vim.cmd('autocmd FileType python lua python_mappings()')

return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        -- first key is the mode
        n = {
          ["<Leader>h"] = false,
          ["<leader>q"] = false,
          ["<Leader>dt"] = { "<cmd>lua require'dap'.terminate()<cr>", desc = "Terminate Session" },
          ["<Leader>;"] = { '"0p', desc = "Put copied value (even after cutting)" },
          ["<S-F1>"] = { "<cmd>let @+=expand('%')<cr>", desc = "Copy relative path of current opened in buffer file" },
          ["<S-F2>"] = { "<cmd>let @+=expand('%:p')<cr>", desc = "Copy absolute path of current opened in buffer file" },
          ["<leader>qw"] = { "<cmd>q<cr>", desc = "Quit from buffer" },
          ["<leader>wq"] = { "<cmd>wqa<cr>", desc = "Quit with saving session and buffers" },

          -- second key is the lefthand side of the map
          -- mappings seen under group name "Buffer"
          -- ["<Leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
          -- ["<Leader>bD"] = {
          --   function()
          --     require("astroui.status").heirline.buffer_picker(function(bufnr)
          --       require("astrocore.buffer").close(bufnr)
          --     end)
          --   end,
          --   desc = "Pick to close",
          -- },
          -- tables with just a `desc` key will be registered with which-key if it's installed
          -- this is useful for naming menus
          -- quick save
          -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command

        },
        t = {
          -- setting a mapping to false will disable it
          -- ["<esc>"] = false,
        },
      },
    },
  }
}
