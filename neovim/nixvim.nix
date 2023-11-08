{ pkgs }: {
  enable = true;

  extraPlugins = with pkgs.vimPlugins; [
    catppuccin-nvim
    lazy-nvim
  ];
  extraPackages = with pkgs; [
    gcc
  ];
  colorscheme = "catppuccin";
  extraConfigLua = "dofile('/home/isabella/nixos/neovim/init.lua')";
}
