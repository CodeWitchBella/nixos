# nu ~/nixos/vscode/gen-extensions.nu
{ extensions = [
  {
    name = "vscode-zipfs";
    publisher = "arcanis";
    version = "3.0.0";
    sha256 = "0wvrqnsiqsxb0a7hyccri85f5pfh9biifq4x2bllpl8mg79l5m68";
  }
  {
    name = "Nix";
    publisher = "bbenoist";
    version = "1.0.1";
    sha256 = "0zd0n9f5z1f0ckzfjr38xw2zzmcxg1gjrava7yahg5cvdcw6l35b";
  }
  {
    name = "vscode-tailwindcss";
    publisher = "bradlc";
    version = "0.11.12";
    sha256 = "1ywb3y2v535dqqdblwz8cr56cnp84bcsqzldsx82a1p29dhi7axq";
  }
  {
    name = "vscode-eslint";
    publisher = "dbaeumer";
    version = "2.4.2";
    sha256 = "1g5mavks3m4fnn7wav659rdnd9f3lp7r96g8niad4g1vaj4xm23q";
  }
  {
    name = "EditorConfig";
    publisher = "EditorConfig";
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
    name = "direnv";
    publisher = "mkhl";
    version = "0.15.2";
    sha256 = "06lp4qgnksklgc6nvx1l9z38y7apbx0a6v886nd15aq9rq8my0ka";
  }
  {
    name = "prisma";
    publisher = "Prisma";
    version = "5.3.1";
    sha256 = "0ya8pq6wj1nv2ws0k0qf7azdkbx6068mha8vlmalwpinkdh3v24y";
  }
  {
    name = "rewrap";
    publisher = "stkb";
    version = "17.8.0";
    sha256 = "1y168ar01zxdd2x73ddsckbzqq0iinax2zv3d95nhwp9asjnbpgn";
  }
  {
    name = "vscode-nushell-lang";
    publisher = "TheNuProjectContributors";
    version = "1.7.0";
    sha256 = "1v9jb7cr8adh7608673nwqdgyjap08i645piisxqdgs3gbxjcv7d";
  }
  {
    name = "vscode-icons";
    publisher = "vscode-icons-team";
    version = "12.5.0";
    sha256 = "0fqawpfwqmj7hiv1g20z3zhs2rv3a9insqd93ad9416mhj89mcry";
  }
  {
    name = "gitblame";
    publisher = "waderyan";
    version = "10.5.1";
    sha256 = "119rf52xnxz0cwvvjjfc5m5iv19288cxz33xzr79b67wyfd79hl9";
  }
  {
    name = "change-case";
    publisher = "wmaurer";
    version = "1.0.0";
    sha256 = "0dxsdahyivx1ghxs6l9b93filfm8vl5q2sa4g21fiklgdnaf7pxl";
  }
];
}