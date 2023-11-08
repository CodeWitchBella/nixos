{ pkgs }: {
    enable = true;

    extraPlugins = [ pkgs.vimPlugins.gruvbox ];
    colorscheme = "gruvbox";
    plugins.lightline.enable = true;
    plugins.telescope = {
        enable = true;
    };
    plugins.lsp.servers.tsserver.enable = true;
    extraConfigLua = "dofile('/home/isabella/nixos/neovim/init.lua')";
}