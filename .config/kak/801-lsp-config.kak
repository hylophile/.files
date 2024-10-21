hook -group lsp-filetype-svelte global BufSetOption filetype=(?:svelte) %{
    set-option buffer lsp_servers %exp{
        [svelteserver]
        filetypes = ["svelte"]
        root_globs = ["package.json", "tsconfig.json", "jsconfig.json", ".git", ".hg"]
        args = ["--stdio"]
        settings_section = "config"
        [svelteserver.settings.config.configuration.typescript]
        inlayHints.parameterTypes.enabled = true
        inlayHints.variableTypes.enabled = true
        inlayHints.propertyDeclarationTypes.enabled = true
        inlayHints.functionLikeReturnTypes.enabled = true
        inlayHints.enumMemberValues.enabled = true
        inlayHints.parameterNames.enabled = "all"
        [svelteserver.settings.config.configuration.javascript]
        inlayHints.parameterTypes.enabled = true
        inlayHints.variableTypes.enabled = true
        inlayHints.propertyDeclarationTypes.enabled = true
        inlayHints.functionLikeReturnTypes.enabled = true
        inlayHints.enumMemberValues.enabled = true
        inlayHints.parameterNames.enabled = "all"

        [tailwindcss-language-server]
        root_globs = ["tailwind.config.ts", "tailwind.config.js"]
        args = ["--stdio"]
        [tailwindcss-language-server.settings.tailwindcss]
        editor = {}
    }
}

hook -group lsp-filetype-python global BufSetOption filetype=python %{
    set-option buffer lsp_servers %{
        [basedpyright-langserver"]
        root_globs = ["requirements.txt", "setup.py", "pyproject.toml", "pyrightconfig.json", ".git", ".hg"]
        args = ["--stdio"]

        [ruff]
        args = ["server", "--quiet"]
        root_globs = ["requirements.txt", "setup.py", "pyproject.toml", ".git", ".hg"]
        settings_section = "_"
        [ruff.settings._.globalSettings]
        organizeImports = true
        fixAll = true
    }
}

