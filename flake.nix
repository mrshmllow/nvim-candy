{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  description = "nvim-candy";
  inputs.flake-parts = {
    url = "github:hercules-ci/flake-parts";
    inputs.nixpkgs-lib.follows = "nixpkgs";
  };
  inputs.devshell.url = "github:numtide/devshell";
  inputs.nightly.url = "github:nix-community/neovim-nightly-overlay";

  inputs.tolerable.url = "github:mrshmllow/tolerable-nvim-nix";
  inputs.tolerable.inputs.nixpkgs.follows = "nixpkgs";
  inputs.tolerable.inputs.nightly.follows = "nightly";

  # Plugins
  inputs.harpoon-nvim.url = "github:ThePrimeagen/harpoon/harpoon2";
  inputs.harpoon-nvim.flake = false;
  inputs.stay-in-place-nvim.url = "github:gbprod/stay-in-place.nvim";
  inputs.stay-in-place-nvim.flake = false;
  inputs.vim-firestore.url = "github:delphinus/vim-firestore";
  inputs.vim-firestore.flake = false;

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } (
      { config, ... }:
      {
        systems = [
          "x86_64-linux"
          "x86_64-darwin"
          "aarch64-linux"
          "aarch64-darwin"
        ];

        imports = [
          inputs.devshell.flakeModule
        ];

        perSystem =
          {
            inputs',
            system,
            config,
            lib,
            pkgs,
            ...
          }:
          let
            tolerableConfig = {
              inherit pkgs;
              src = lib.fileset.toSource {
                root = ./.;
                fileset = ./candy;
              };

              package = inputs.tolerable.packages.${pkgs.stdenv.hostPlatform.system}.nightly.overrideAttrs (old: {
                patches = old.patches or [ ] ++ [
                  # revert fix for previous patch
                  (pkgs.fetchpatch2 {
                    url = "https://github.com/echasnovski/neovim/commit/cd712212509884d959c464f94bca15f881d95f1b.diff";
                    hash = "sha256-+ibLxtsLcqi8HN5wIy2EhNs5QkKMeYsmEocqjf/M6uA=";
                    revert = true;
                  })
                  # revert logo
                  (pkgs.fetchpatch2 {
                    url = "https://patch-diff.githubusercontent.com/raw/neovim/neovim/pull/38378.diff";
                    hash = "sha256-ig5SjPqLDQb9by7UJJgvJ/rIlgu0rE694kMrri+Y4vs=";
                    revert = true;
                  })
                ];
              });

              path = with pkgs; [
                curl
                git
                stylua
                prettierd
                black
                nixfmt
                taplo
                lua-language-server
                nil
                statix
                # typescript-language-server
                typescript-go
                tailwindcss-language-server
                # nodePackages.sql-formatter
                gopls
                golangci-lint-langserver
                golangci-lint
                pyright
                tinymist
                ripgrep
                gdb
                llvmPackages_20.clang-tools

                asm-lsp
                vscode-langservers-extracted
              ];
              config = {
                plugins =
                  let
                    opt = plugin: {
                      inherit plugin;
                      optional = true;
                    };
                  in
                  with pkgs.vimPlugins;
                  [
                    lz-n
                    nvim-treesitter.withAllGrammars
                    nvim-lspconfig
                    lackluster-nvim
                    everforest
                    mini-nvim
                    luasnip
                    (opt conform-nvim)
                    plenary-nvim
                    (pkgs.vimUtils.buildVimPlugin {
                      src = inputs.harpoon-nvim;
                      name = "harpoon";
                      doCheck = false;
                    })
                    rustaceanvim
                    direnv-vim
                    vim-dotenv
                    (opt nvim-spider)
                    vim-fugitive
                    vim-gnupg
                    fidget-nvim
                    hardtime-nvim
                  ];
              };
            };
          in
          {
            packages = {
              neovim = inputs.tolerable.makeNightlyNeovimConfig "candy" tolerableConfig;

              default = config.packages.neovim;

              testing = inputs.tolerable.makeNightlyNeovimConfig "candy" (
                tolerableConfig
                // {
                  testing = true;
                }
              );
            };
          };

        flake =
          let
            package = inputs.nixpkgs.lib.genAttrs config.systems (
              system: inputs.self.packages.${system}.default
            );
          in
          {
            defaultPackage = package;
          };
      }
    );
}
