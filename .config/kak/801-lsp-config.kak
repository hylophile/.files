hook global BufSetOption filetype=(?:svelte) %{
    set-option buffer lsp_servers %exp{
		[svelteserver]
		filetypes = ["svelte"]
        root = "%sh{eval "$kak_opt_lsp_find_root" package.json tsconfig.json jsconfig.json $(: kak_buffile)}"
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
        root = "%sh{eval "$kak_opt_lsp_find_root" tailwind.config.ts tailwind.config.js $(: kak_buffile)}"
        args = ["--stdio"]
        [tailwindcss-language-server.settings.tailwindcss]
        editor = {}
    }
}
