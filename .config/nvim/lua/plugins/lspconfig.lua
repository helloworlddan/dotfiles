local language_id_of = {
  menhir = "ocaml.menhir",
  ocaml = "ocaml",
  ocamlinterface = "ocaml.interface",
  ocamllex = "ocaml.ocamllex",
  reason = "reason",
  dune = "dune",
}

return {
  {
    "neovim/nvim-lspconfig",
    setup = function()
      require("lspconfig").gopls.setup({
        settings = {
          gopls = {
            analyses = {
              modernize = true,
            },
          },
        },
      })
    end,
    opts = {
      servers = {
        ocamllsp = {
          get_language_id = function(_, ftype)
            return language_id_of[ftype]
          end,
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern(
              "*.opam",
              "easy.json",
              "package.json",
              ".git",
              "dune-project",
              "dune-workspace",
              "*.ml"
            )(fname)
          end,
        },
      },
    },
  },
}
