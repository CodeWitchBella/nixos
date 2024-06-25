# nu ~/nixos/vscode/gen-extensions.nu
{
  extensions = [
    {
      name = "vscode-zipfs";
      publisher = "arcanis";
      version = "3.0.0";
      sha256 = "0wvrqnsiqsxb0a7hyccri85f5pfh9biifq4x2bllpl8mg79l5m68";
    }
    {
      name = "nix";
      publisher = "bbenoist";
      version = "1.0.1";
      sha256 = "0zd0n9f5z1f0ckzfjr38xw2zzmcxg1gjrava7yahg5cvdcw6l35b";
    }
    {
      name = "vscode-tailwindcss";
      publisher = "bradlc";
      version = "0.11.70";
      sha256 = "1fssz70f76xl93fik1b9hmbxbg516kv2474xhqbix3l275d0rgxj";
    }
    {
      name = "vscode-eslint";
      publisher = "dbaeumer";
      version = "3.0.7";
      sha256 = "03ii58jpvmbl5kwq34cmx0f2x08rla75sn32fv0xns5jprjxaaiy";
    }
    {
      name = "biome";
      publisher = "biomejs";
      version = "2.3.0";
      sha256 = "sha256-GrMyXn5yfxjbUi0YuioPX137P+8TWdh5V6HC0kvLFYE=";
    }
    {
      name = "vscode-sqlfluff";
      publisher = "dorzey";
      version = "3.0.2";
      sha256 = "1y3x1j301rigci3v1pc8i3q9qynagg5xkdbv7npy923aicri5plj";
    }
    {
      name = "editorconfig";
      publisher = "editorconfig";
      version = "0.16.4";
      sha256 = "0fa4h9hk1xq6j3zfxvf483sbb4bd17fjl5cdm3rll7z9kaigdqwg";
    }
    {
      name = "prettier-vscode";
      publisher = "esbenp";
      version = "10.4.0";
      sha256 = "1iy7i0yxnhizz40llnc1dk9q8kk98rz6ki830sq7zj3ak9qp9vzk";
    }
    {
      name = "alejandra";
      publisher = "kamadorueda";
      version = "1.0.0";
      sha256 = "1ncjzhrc27c3cwl2cblfjvfg23hdajasx8zkbnwx5wk6m2649s88";
    }
    {
      name = "kdl";
      publisher = "kdl-org";
      version = "1.3.1";
      sha256 = "1a302y4xkqng5pbiyzxlr3mpl1r9g4813m14gzzjh6wsmj3z4rni";
    }
    {
      name = "openscad-language-support";
      publisher = "leathong";
      version = "1.2.5";
      sha256 = "17yqkl0yglxpsibjh3i50p4fg4bsfn61lnj49wjzclfxfl2z28pw";
    }
    {
      name = "direnv";
      publisher = "mkhl";
      version = "0.17.0";
      sha256 = "1n2qdd1rspy6ar03yw7g7zy3yjg9j1xb5xa4v2q12b0y6dymrhgn";
    }
    {
      name = "mypy-type-checker";
      publisher = "ms-python";
      version = "2023.9.11501016";
      sha256 = "072k06bzyg5ih66d5sg0i21p7qpc897y6qyx8pjfihrj7v4kwxwq";
    }
    {
      name = "python";
      publisher = "ms-python";
      version = "2024.7.11511013";
      sha256 = "1zajibw9g9k5j9s9x7b798vwv06hvj66fgl7mm06p2r4l26i6j2g";
    }
    {
      name = "vscode-pylance";
      publisher = "ms-python";
      version = "2024.5.103";
      sha256 = "1skfpk5020prdylzzig8xgwlzg09rhi7676g7cf9sa4zrm4knjyf";
    }
    {
      name = "remote-ssh";
      publisher = "ms-vscode-remote";
      version = "0.112.2024053015";
      sha256 = "06rpdyj7w2qlkk766cwx4430lrzn953ya2z8nzvfsl4zhjmskxmx";
    }
    {
      name = "prisma";
      publisher = "prisma";
      version = "5.14.0";
      sha256 = "0bxn8ixkd0yvwcgds44gp3i3rkvkhxb16z4nvb4chvvp199bnw5i";
    }
    {
      name = "rust-analyzer";
      publisher = "rust-lang";
      version = "0.4.1981";
      sha256 = "0zazrh47izfpx0ks5rf3wbzvs0z7nay1dvg2splzqrdaivk3m6qw";
    }
    {
      name = "rewrap";
      publisher = "stkb";
      version = "17.8.0";
      sha256 = "1y168ar01zxdd2x73ddsckbzqq0iinax2zv3d95nhwp9asjnbpgn";
    }
    {
      name = "even-better-toml";
      publisher = "tamasfe";
      version = "0.19.2";
      sha256 = "0q9z98i446cc8bw1h1mvrddn3dnpnm2gwmzwv2s3fxdni2ggma14";
    }
    {
      name = "vscode-nushell-lang";
      publisher = "thenuprojectcontributors";
      version = "1.9.0";
      sha256 = "130kxrvgxxndrncl49wgs8ga7gcc9vabdxz39yczqxx1c3y8ml0k";
    }
    {
      name = "vscode-mdx";
      publisher = "unifiedjs";
      version = "1.8.7";
      sha256 = "1wphlv0wffdf2hgpwfb92ij0sr9xwbli8haa9bxzbqqryav6bl3c";
    }
    {
      name = "vscode-icons";
      publisher = "vscode-icons-team";
      version = "12.8.0";
      sha256 = "04rb6r7hv1d3gn62rfldz29bzxdpiikgdh188179q2zx0b89zrfv";
    }
    {
      name = "gitblame";
      publisher = "waderyan";
      version = "11.0.1";
      sha256 = "0ahvhk8rgyr2jhqnkr89y195wn4vadgcs8ibpms260iyflrv7x2k";
    }
    {
      name = "change-case";
      publisher = "wmaurer";
      version = "1.0.0";
      sha256 = "0dxsdahyivx1ghxs6l9b93filfm8vl5q2sa4g21fiklgdnaf7pxl";
    }
  ];
}
