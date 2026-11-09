local set = vim.keymap.set

return {
  "neoclide/coc.nvim",
  branch = "master",
  build = "yarn install --frozen-lockfile",
  event = "VeryLazy",

  config = function()
    local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }

    function _G.check_back_space()
      local col = vim.fn.col('.') - 1
      return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
    end

    -- set("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
    -- set("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
    set("i", "<C-n>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
    set("i", "<C-p>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
    set("i", "<C-space>", "coc#refresh()", { silent = true, expr = true })
    set("i", "<C-m>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
    -- set("i", "<C-l>", "<Plug>(coc-snippets-expand)")

    set("n", "gn", "<Plug>(coc-diagnostic-next)", { silent = true })
    set("n", "gp", "<Plug>(coc-diagnostic-prev)", { silent = true })

    function _G.show_docs()
      local cw = vim.fn.expand('<cword>')
      if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
      elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
      else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
      end
    end

    set("n", "<leader>sd", '<CMD>lua _G.show_docs()<CR>', { silent = true })
    set("n", "<leader>rn", "<Plug>(coc-rename)", { silent = true })
  end
}
