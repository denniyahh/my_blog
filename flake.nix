{
  description = "Development shell for my_blog Jekyll project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            ruby_3_3
            bundler
            nodejs_22
            nodePackages.pnpm
            nodePackages.markdownlint-cli2
            git
            neovim
            openssl
            pkg-config
            libffi
            zlib
            which
            libyaml
            curl
            broot
            zellij
            fzf
            chromium
            broot
            zellij
            fzf
          ];

         shellHook = ''
           export GEM_HOME=$PWD/.bundler
           export PATH=$GEM_HOME/bin:$PATH
            export LD_LIBRARY_PATH=${pkgs.curl.out}/lib''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}

            echo "Dev shell ready. Run 'bundle install' and 'pnpm install' if you haven't already."
          '';
        };
      });
}
