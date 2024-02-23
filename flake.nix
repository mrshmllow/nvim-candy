{
  description = "my-neovim";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.overlay.url = "github:nix-community/neovim-nightly-overlay";

  inputs.harpoon-nvim.url = "github:ThePrimeagen/harpoon/harpoon2";
  inputs.harpoon-nvim.flake = false;
  inputs.stay-in-place-nvim.url = "github:gbprod/stay-in-place.nvim";
  inputs.stay-in-place-nvim.flake = false;

  outputs = inputs @ {
    nixpkgs,
    self,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      inherit (nixpkgs) lib;

      pkgs = nixpkgs.legacyPackages.${system};
      neovim = inputs.overlay.packages.${system}.default;
      config = pkgs.neovimUtils.makeNeovimConfig {
        plugins = with pkgs.vimPlugins; [
          nvim-treesitter.withAllGrammars
          nvim-lspconfig
          catppuccin-nvim
          mini-nvim
          luasnip
          conform-nvim
          plenary-nvim
          which-key-nvim
          (pkgs.vimUtils.buildVimPlugin {
            src = inputs.harpoon-nvim;
            name = "harpoon";
          })
          rustaceanvim

          # nvim-cmp
          nvim-cmp
          cmp-nvim-lsp
          cmp-cmdline
          cmp-async-path
          cmp-buffer
          luasnip
          cmp_luasnip
        ];
        customRC = "";
      };

      nvim-package = pkgs.wrapNeovimUnstable neovim (config
        // {
          wrapRc = false;
        });

      bin = pkgs.writeScriptBin "nvim" ''
        NVIM_APPNAME=candy XDG_CONFIG_HOME=${./.} ${lib.getExe nvim-package} "$@"
      '';
    in {
      packages.default = bin;
      devShells.default = pkgs.mkShell {
        packages = [bin];
      };
    });
}
