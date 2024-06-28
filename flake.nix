{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  description = "nvim-candy";
  inputs.flake-parts = {
    url = "github:hercules-ci/flake-parts";
    inputs.nixpkgs-lib.follows = "nixpkgs";
  };
  inputs.devshell.url = "github:numtide/devshell";
  inputs.nightly.url = "github:nix-community/neovim-nightly-overlay";

  # Plugins
  inputs.harpoon-nvim.url = "github:ThePrimeagen/harpoon/harpoon2";
  inputs.harpoon-nvim.flake = false;
  inputs.stay-in-place-nvim.url = "github:gbprod/stay-in-place.nvim";
  inputs.stay-in-place-nvim.flake = false;
  inputs.supermaven-nvim.url = "github:supermaven-inc/supermaven-nvim";
  inputs.supermaven-nvim.flake = false;

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} ({config, ...}: {
      systems = [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      imports = [
        inputs.devshell.flakeModule
      ];

      perSystem = {
        inputs',
        system,
        config,
        lib,
        pkgs,
        ...
      }: {
        packages = let
          unstable = inputs'.nightly.packages.neovim.overrideAttrs (old: {
            patches = [./0001-NIX_ABS_PATH.patch];
          });
          nvim-config = pkgs.neovimUtils.makeNeovimConfig {
            plugins = with pkgs.vimPlugins; [
              nvim-treesitter.withAllGrammars
              nvim-lspconfig
              catppuccin-nvim
              kanagawa-nvim
              mini-nvim
              luasnip
              conform-nvim
              plenary-nvim
              which-key-nvim
              (pkgs.vimUtils.buildVimPlugin {
                src = inputs.harpoon-nvim;
                name = "harpoon";
              })
              (pkgs.vimUtils.buildVimPlugin {
                src = inputs.supermaven-nvim;
                name = "supermaven";
              })
              rustaceanvim
              heirline-nvim
              nvim-web-devicons
              typescript-tools-nvim
              direnv-vim
              vim-dotenv
              nvim-spider
              vim-fugitive
              gitsigns-nvim

              # nvim-cmp
              nvim-cmp
              cmp-nvim-lsp
              cmp-cmdline
              cmp-async-path
              cmp-buffer
              luasnip
              cmp_luasnip
            ];
            wrapRc = false;
          };
        in {
          neovim = (pkgs.wrapNeovimUnstable unstable nvim-config).overrideAttrs (old: {
            generatedWrapperArgs =
              old.generatedWrapperArgs
              or []
              ++ [
                "--set"
                "NVIM_APPNAME"
                "candy"
                "--set"
                "NIX_ABS_CONFIG"
                "${./.}"
              ];
            buildInputs = with pkgs;
              old.buildInputs
              or []
              ++ [
                curl
                git
                stylua
                prettierd
                alejandra
                taplo
                nodePackages.sql-formatter
              ];
            doCheck = true;
            checkPhase = ''
              CANDY_CHECK=1 $out/bin/nvim \
                --headless \
                --cmd "source ${./pre-check.lua}" \
                -c "source ${./post-check.lua}" || (>&2 cat stderr.txt && exit 1)
            '';
          });

          default = config.packages.neovim;
        };
      };

      flake = let
        package = inputs.nixpkgs.lib.genAttrs config.systems (system: inputs.self.packages.${system}.default);
      in {
        defaultPackage = package;
      };
    });
}
