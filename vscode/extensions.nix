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
      version = "0.11.48";
      sha256 = "1kivvgrccd5yr5cgivn0q1c7p1vf8ls8jg2g7d0qdm7rr8p1vz6c";
    }
    {
      name = "ruff";
      publisher = "charliermarsh";
      version = "2024.16.0";
      sha256 = "0yqk44p4di0h9l2b5i06nndwr4ss7w6b6dlpmig1aw5f9zfdf6ja";
    }
    {
      name = "vscode-eslint";
      publisher = "dbaeumer";
      version = "2.4.4";
      sha256 = "1c10n36a3bxwwjgd4vhrf79wg14dm0hxvz9z23pqdyxzcwrar49l";
    }
    {
      name = "vscode-sqlfluff";
      publisher = "dorzey";
      version = "2.4.4";
      sha256 = "1vlh8jazpzc0a8zziyn4n2ifbkjn16r3hcw30d25x41p2n45nkg3";
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
      version = "10.1.0";
      sha256 = "01s0vi2h917mqfpdrhqhp2ijwkibw95yk2js0l587wvajbbry2s9";
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
      version = "0.16.0";
      sha256 = "1jmwqbbh5x5z7dscgcn4pb0g41k7zlhgf5i8syl3ipv6z270aq5v";
    }
    {
      name = "mypy-type-checker";
      publisher = "ms-python";
      version = "2023.9.10221010";
      sha256 = "0kp0pzjd5mi40hn3s1d3pfxykhy0qc9wnr11lvjg3kf6dv4kyjf2";
    }
    {
      name = "python";
      publisher = "ms-python";
      version = "2024.3.10681011";
      sha256 = "0lx82p85qm2256qnzmb0mfsxfc3wzi94wamki0gyy202gv297yhj";
    }
    {
      name = "vscode-pylance";
      publisher = "ms-python";
      version = "2024.2.106";
      sha256 = "1kz337x9k0im2clrga8244wscfkwkz591i10q6mnlivphvc1qp1s";
    }
    {
      name = "remote-ssh";
      publisher = "ms-vscode-remote";
      version = "0.110.2024030815";
      sha256 = "1cagvj5jr6s01m3vk22yywmsqb4cmb77gf533xzl236r34ika1b6";
    }
    {
      name = "prisma";
      publisher = "prisma";
      version = "5.10.2";
      sha256 = "12vbarlq2cn8x72h1c068dh646m1cvi4jazmwmjr5fxgf20ykjck";
    }
    {
      name = "rust-analyzer";
      publisher = "rust-lang";
      version = "0.4.1878";
      sha256 = "13af325vh0sgi1vqgwv06w8ywhlmhpyhsy1ykdphkkaib4bcqpnz";
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
      version = "1.8.1";
      sha256 = "06lzj4iqr5n8bd785603kmq01liifrky2ab980rhnswdjgn1nv7z";
    }
    {
      name = "vscode-icons";
      publisher = "vscode-icons-team";
      version = "12.7.0";
      sha256 = "1w30gd0chf2c26a9c426ghs7gmss9dk9yzlrab51ydwhfkkd4hxb";
    }
    {
      name = "gitblame";
      publisher = "waderyan";
      version = "10.9.0";
      sha256 = "05ikbw71jki82crr960wfnvsl2d73pi9ilh14qpg87q06500wg22";
    }
    {
      name = "change-case";
      publisher = "wmaurer";
      version = "1.0.0";
      sha256 = "0dxsdahyivx1ghxs6l9b93filfm8vl5q2sa4g21fiklgdnaf7pxl";
    }
  ];
}
