-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Directly run the Arch system Lua module for TOhtml

-- Directly run the Arch system Lua module and generate a fresh buffer
vim.api.nvim_create_user_command("TOhtml", function()
  -- 1. Temporarily pause semantic tokens to stop the warning popup
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    if client.server_capabilities.semanticTokensProvider then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end

  -- 2. Grab the system's core Lua execution script
  local system_tohtml = loadfile("/usr/share/nvim/runtime/pack/dist/opt/nvim.tohtml/lua/tohtml.lua")

  if system_tohtml then
    local tohtml = system_tohtml()

    -- 3. Capture the raw HTML strings returned by the Neovim module
    local current_win = vim.api.nvim_get_current_win()
    local html_lines = tohtml.tohtml(current_win) -- returns a table/list of strings

    if html_lines and #html_lines > 0 then
      -- 4. Create an empty scratch buffer (not listed in regular file lists, unlinked to disk)
      local html_buf = vim.api.nvim_create_buf(true, true)

      -- 5. Put the raw HTML strings inside our newly created buffer
      vim.api.nvim_buf_set_lines(html_buf, 0, -1, false, html_lines)

      -- 6. Open a vertical window split and assign our new buffer to it
      vim.cmd("vsplit")
      local new_win = vim.api.nvim_get_current_win()
      vim.api.nvim_win_set_buf(new_win, html_buf)

      -- 7. Turn on HTML syntax highlighting for our new split screen view
      vim.api.nvim_set_option_value("filetype", "html", { buf = html_buf })
    else
      vim.notify("Failed to generate HTML content strings.", vim.log.levels.ERROR)
    end
  else
    vim.notify("Could not find the system tohtml script path.", vim.log.levels.ERROR)
  end
end, { range = true })
