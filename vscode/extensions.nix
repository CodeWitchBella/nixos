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
      version = "0.11.63";
      sha256 = "1rcx9a02j8jx0w0zwcnalrpcd4ding4hbaw1hvvl96rra3v5c1v3";
    }
    {
      name = "vscode-eslint";
      publisher = "dbaeumer";
      version = "3.0.5";
      sha256 = "1cmkgi1i5c7qkrr8cif36i803yl6mrv87y9gmzfb701pcfg8yxx9";
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
      version = "2023.9.10961015";
      sha256 = "0ndpgshv22f8cm5j741mqrlw6iksc6ny2qsb469v3wg4ga5dw5c3";
    }
    {
      name = "python";
      publisher = "ms-python";
      version = "2024.5.11021008";
      sha256 = "11mnnbdl7cqr18s2cvv2132rrq1f5zslnihp5i2jpa2awjak8wjj";
    }
    {
      name = "vscode-pylance";
      publisher = "ms-python";
      version = "2024.4.101";
      sha256 = "13yi6v1l7k1g0r7fhw3gasv7drn03slh0lxp6pcmqlrajkp0cn1n";
    }
    {
      name = "remote-ssh";
      publisher = "ms-vscode-remote";
      version = "0.112.2024040915";
      sha256 = "06cz4q82aw0nzlqc06dnkn7nx2hc66plw1pqbfsn42l42g35d1fz";
    }
    {
      name = "prisma";
      publisher = "prisma";
      version = "5.12.1";
      sha256 = "1362636pag1a0i241i08j4289skxgjafv14c4dwzk0lgb7j8vxvv";
    }
    {
      name = "rust-analyzer";
      publisher = "rust-lang";
      version = "0.4.1926";
      sha256 = "0js1qsmx7m8s6vz9widpsnrmy9scqdwpxbrmgfasihn0i5vlqhkv";
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
      version = "1.8.3";
      sha256 = "03z8rrkcigzkv1g4p1wapiwwsrbrf5nbq8hgaxxli9b8p6b64m2q";
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
      version = "10.10.0";
      sha256 = "1qahqqdbqzagzka5qc6znf7imvgpcn5k4zk5cqnwcr1g2ckinrxm";
    }
    {
      name = "change-case";
      publisher = "wmaurer";
      version = "1.0.0";
      sha256 = "0dxsdahyivx1ghxs6l9b93filfm8vl5q2sa4g21fiklgdnaf7pxl";
    }
  ];
}
