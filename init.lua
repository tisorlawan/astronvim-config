return {
  -- Configure AstroNvim updates
  --
  --
  updater = {
    remote = "origin",     -- remote to use
    channel = "stable",    -- "stable" or "nightly"
    version = "latest",    -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly",    -- branch name (NIGHTLY ONLY)
    commit = nil,          -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil,     -- nil, true, false (nil will pin plugins on stable only) skip_prompts = false,  -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false,     -- automatically quit the current session after a successful update
    remotes = {            -- easily add new remotes to track
      --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
      --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
      --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    },
  },
  -- Set colorscheme to use
  colorscheme = "kanagawa",
  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = false,
  },
  lsp = {
    -- customize lsp formatting options
    --
    on_attach = function(client, _)
      if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_del_augroup_by_name "lsp_document_highlight"
      end

      -- if client.name == "tsserver" then
      --   local ns = vim.lsp.diagnostic.get_namespace(client.id)
      --   vim.diagnostic.disable(nil, ns)
      -- end
    end,
    formatting = {
      format_on_save = {
        enabled = true,
        allow_filetypes = {},
        ignore_filetypes = {},
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- "sumneko_lua",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {},
    config = {
      pyright = {
        handlers = {
          ["textDocument/publishDiagnostics"] = function()
          end,
        },
        on_attach = function(client, _) client.server_capabilities.codeActionProvider = false end,
        settings = {
          pyright = {
            disableOrganizeImports = true,
          },
          python = {
            analysis = {
              autoSearchPaths = true,
              typeCheckingMode = "basic",
              useLibraryCodeForTypes = true,
            },
          },
        },
      },
    },
  },
  -- Configure require("lazy").setup() options
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin" },
      },
    },
  },
  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    -- Set up custom filetypes
    vim.filetype.add {
      --   extension = {
      --     foo = "fooscript",
      --   },
      filename = {
        [".env"] = "bash",
        [".env.example"] = "bash",
        [".env.production"] = "bash",
        [".env.development"] = "bash",
        [".env.template"] = "bash",
        -- ["justfile"] = "make",
      },
      --   pattern = {
      --     ["~/%.config/foo/.*"] = "fooscript",
      --   },
    }
    vim.cmd [[
      nmap <leader>q  <plug>(GrepperOperator)
      xmap <leader>q  <plug>(GrepperOperator)
      hi TreesitterContextBottom guibg=black
    ]]

    local semiColonGrp = vim.api.nvim_create_augroup("SemicolonGroup", { clear = true })
    vim.api.nvim_create_autocmd({ "FileType" }, {
      pattern = { "svelte", "rust" },
      command = [[ lua require('user.utils').SemiColonConfig()]],
      group = semiColonGrp,
    })
  end,
}
