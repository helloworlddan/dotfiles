return {
  {
    "kiddos/gemini.nvim",
    config = function()
      require("gemini").setup({
        completion = {
          insert_result_key = "<S-space>",
        },
      })
    end,
  },
}
