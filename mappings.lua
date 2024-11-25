-- remove auto comment on next line and other
vim.api.nvim_exec([[
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
]], false)


-- vim.cmd('filetype plugin on')


map = function(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  for k, v in pairs(opts or {}) do
    options[k] = v
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- python_mappings = function()
--   map('n', '<F1>', "<cmd>lua require'dap'.run(LaunchAppConf)<cr>")
--   map('n', '<F2>', "<cmd>lua require'dap'.run(LaunchFileConf)<cr>")
--   map('n', '<F3>', "<cmd>lua require'dap'.run(DjangoConf)<cr>")
--   -- map('n', '<Leader><F4>', "<cmd>lua require'dap'.run(fastapi_conf)<cr>")
--   map('n', '<F5>', "<cmd>lua require'dap'.run(LaunchTestConf)<cr>")
-- end
--
-- vim.cmd('autocmd FileType python lua python_mappings()')

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
          ["gr"] = { "<cmd>Telescope lsp_references<cr>", desc = "References on this variable" },
          ["grr"] = false;
          ["grn"] = false;
          ["gra"] = false;
          ["<Leader>dl"] = { "<cmd>lua require'dap'.run_last()<cr>", desc = "Run last configuration" },
          ["<Leader>;"] = { '"0p', desc = "Put copied value (even after cutting)" },
          ["<Leader>1"] = { "<cmd>let @+=expand('%')<cr>", desc = "Copy relative path of current opened in buffer file" },
          ["<Leader>2"] = { "<cmd>let @+=expand('%:p')<cr>", desc = "Copy absolute path of current opened in buffer file" },
          ["<leader>qw"] = { "<cmd>q<cr>", desc = "Quit from buffer" },
          ["<leader>wq"] = { "<cmd>wqa<cr>", desc = "Quit with saving session and buffers" },
        },
      },
    },
  }
}
