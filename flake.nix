{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  description = "nvim-candy";
  inputs.flake-parts = {
    url = "github:hercules-ci/flake-parts";
    inputs.nixpkgs-lib.follows = "nixpkgs";
  };
  inputs.devshell.url = "github:numtide/devshell";
  inputs.nightly.url = "github:nix-community/neovim-nightly-overlay";

  inputs.tolerable.url = "github:wires-org/tolerable-nvim-nix";
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
              path = with pkgs; [
                curl
                git
                stylua
                prettierd
                black
                nixfmt-rfc-style
                taplo
                lua-language-server
                nil
                statix
                nodePackages.typescript-language-server
                tailwindcss-language-server
                nodePackages.sql-formatter
                gopls
                golangci-lint-langserver
                golangci-lint
                pyright
                tinymist
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
                    catppuccin-nvim
                    mini-nvim
                    colorizer
                    luasnip
                    (opt conform-nvim)
                    plenary-nvim
                    (pkgs.vimUtils.buildVimPlugin {
                      src = inputs.harpoon-nvim;
                      name = "harpoon";
                      doCheck = false;
                    })
                    rustaceanvim
                    lackluster-nvim
                    typescript-tools-nvim
                    direnv-vim
                    vim-dotenv
                    (opt nvim-spider)
                    vim-fugitive
                    gitsigns-nvim
                    vim-gnupg
                    fidget-nvim
                    presence-nvim
                    hardtime-nvim
                    (pkgs.vimUtils.buildVimPlugin {
                      src = inputs.vim-firestore;
                      name = "firestore";
                    })

                    # nvim-cmp
                    nvim-cmp
                    cmp-nvim-lsp
                    cmp-cmdline
                    cmp-async-path
                    cmp-buffer
                    luasnip
                    cmp_luasnip
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
