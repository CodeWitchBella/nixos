{ pkgs }: {
  enable = true;

  plugins = with pkgs.vimPlugins; [
    lazy-nvim
  ];
  extraPackages = with pkgs; [
    gcc
  ];
  extraLuaConfig = "dofile('/home/isabella/nixos/neovim/init.lua')";
}
