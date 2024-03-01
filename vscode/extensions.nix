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
      version = "0.11.40";
      sha256 = "10z3gj6jcyszsg6nkqdsfvkl7jhcw5p55122g9515v20vdwqwg4y";
    }
    {
      name = "ruff";
      publisher = "charliermarsh";
      version = "2024.14.0";
      sha256 = "054qbx5kmkqpz4mv0h3jmh5fj77gnwl3valjjrm2wh7hbc2acasi";
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
      version = "2024.3.10611008";
      sha256 = "0n2ndv9ssyxd7ybwlrza912h5lrdmgzd9ss38jaqnqxzz45bisns";
    }
    {
      name = "vscode-pylance";
      publisher = "ms-python";
      version = "2024.2.105";
      sha256 = "0iyz05nbkfmpn564axnd2fi1a4h15nr9yq3lzrxyd6zd7wk5ax73";
    }
    {
      name = "remote-ssh";
      publisher = "ms-vscode-remote";
      version = "0.110.2024022915";
      sha256 = "0lqq2fywph6z0r91sj2y45gsi4768fkwmlaj12xblphsy7rp4zjw";
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
      version = "0.4.1864";
      sha256 = "0y4b8iiyvn4vhx6myl7l4gv764cvpsmdj97bpyz6jrnpm3c8q1y6";
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
      version = "1.8.0";
      sha256 = "1mpnb8grs9ga1r7qw9qixa6ikl48k40rxqjkysxr37p89gkwsbja";
    }
    {
      name = "vscode-mdx";
      publisher = "unifiedjs";
      version = "1.7.3";
      sha256 = "1jiwk59fhkjvjkax4skclmfv260lwp27fkmm1v0ybpvq8x22pa5f";
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
