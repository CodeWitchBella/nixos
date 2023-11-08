{ pkgs }: {
    enable = true;

    extraPlugins = [ pkgs.vimPlugins.gruvbox ];
    colorscheme = "gruvbox";
    plugins.lightline.enable = true;
    plugins.telescope = {
        enable = true;
    };
    plugins.lsp.servers.tsserver.enable = true;
    keymaps = [
        {
            action = "require('telescope.builtin').find_files";
            key = "<leader>ff";
            mode = "n";
            lua = true;
        }
    ];
}