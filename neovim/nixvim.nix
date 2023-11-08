{ pkgs }: {
    enable = true;

    extraPlugins = with pkgs.vimPlugins; [
        catppuccin-nvim

        # Git related plugins
        fugitive
        rhubarb

        # Detect tabstop and shiftwidth automatically
        vim-sleuth

        # LSP
        nvim-lspconfig

        # Autocompletion
        nvim-cmp

        # Useful plugin to show you pending keybinds.
        which-key-nvim

        # Adds git related signs to the gutter, as well as utilities for managing changes
        gitsigns-nvim

        # Set lualine as statusline
        lualine-nvim

        # the rest
        mason-nvim
        mason-lspconfig-nvim
        neodev-nvim
        cmp-nvim-lsp
        cmp_luasnip
        luasnip
    ];
    colorscheme = "catppuccin";
    plugins = {
        telescope.enable = true;

        # Highlight, edit, and navigate code
        treesitter.enable = true;
    };
    extraConfigLua = "dofile('/home/isabella/nixos/neovim/init.lua')";
}
