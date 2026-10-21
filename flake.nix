{
  description = "nvim-candy";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    devshell.url = "github:numtide/devshell";
    nightly.url = "github:nix-community/neovim-nightly-overlay";

    tolerable = {
      url = "github:mrshmllow/tolerable-nvim-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nightly.follows = "nightly";
    };

    # Plugins
    stay-in-place-nvim = {
      url = "github:gbprod/stay-in-place.nvim";
      flake = false;
    };

    neovide = {
      url = "github:neovide/neovide/nightly";
      flake = false;
    };
  };

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
            self',
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
                  # (pkgs.fetchpatch2 {
                  #   url = "https://github.com/echasnovski/neovim/commit/cd712212509884d959c464f94bca15f881d95f1b.diff";
                  #   hash = "sha256-+ibLxtsLcqi8HN5wIy2EhNs5QkKMeYsmEocqjf/M6uA=";
                  #   revert = true;
                  # })
                  # revert logo
                  # (pkgs.fetchpatch2 {
                  #   url = "https://patch-diff.githubusercontent.com/raw/neovim/neovim/pull/38378.diff";
                  #   hash = "sha256-ig5SjPqLDQb9by7UJJgvJ/rIlgu0rE694kMrri+Y4vs=";
                  #   revert = true;
                  # })
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
                typescript
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

                haskell-language-server
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

              neovide =
                let
                  package = pkgs.neovide.overrideAttrs (old: rec {
                    version = "unstable";

                    src = inputs.neovide;

                    cargoDeps = pkgs.rustPlatform.fetchCargoVendor {
                      inherit src;
                      hash = "sha256-wYuJxxNPl7pUY/lkVMUoKceBJFDHgGrusYKoUTmoRIM=";
                    };

                    # skia-bindings 0.153.3
                    env = old.env // {
                      SKIA_SOURCE_DIR =
                        let
                          skiaRepo = pkgs.fetchFromGitHub {
                            owner = "rust-skia";
                            repo = "skia";
                            tag = "m153-0.101.2";
                            hash = "sha256-xKCkvQoTAMlLvKdVzzSxTST6kER4kRUIDjvTRZ9z72o=";
                          };
                          externals = pkgs.linkFarm "skia-externals" (
                            lib.mapAttrsToList (name: value: {
                              inherit name;
                              path = pkgs.fetchgit value;
                            }) (lib.importJSON ./skia-externals.json)
                          );
                        in
                        pkgs.runCommand "source" { } ''
                          cp -R ${skiaRepo} $out
                          chmod -R +w $out
                          ln -s ${externals} $out/third_party/externals
                        '';
                    };
                  });
                in
                pkgs.symlinkJoin {
                  inherit (package) name version meta;
                  paths = [ package ];
                  nativeBuildInputs = [ pkgs.makeWrapper ];
                  postBuild = ''
                    wrapProgram $out/bin/neovide \
                        --set-default NEOVIM_BIN ${lib.getExe self'.packages.neovim} \
                        --set-default NEOVIDE_FRAME none
                  '';
                };
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
