# Neovim Config

Neovim config for myself

```bash 
nix run github:mrshmllow/nvim-candy
```

- Attempts to rely on as few plugins as possible
- `$NVIM_APPNAME=candy` as to not cause conflicts
- Patches in a new env var, `$NIX_ABS_CONFIG`
- all custom lua is under the `require("marshmallow\..*")` space

## Output

```
$ nix flake show --all-systems
git+file:///home/marsh/projects/nvim-candy
├───defaultPackage
│   ├───aarch64-darwin: package 'nvim'
│   ├───aarch64-linux: package 'nvim'
│   ├───x86_64-darwin: package 'nvim'
│   └───x86_64-linux: package 'nvim'
└───packages
    ├───aarch64-darwin
    │   ├───default: package 'nvim'
    │   └───neovim: package 'nvim'
    ├───aarch64-linux
    │   ├───default: package 'nvim'
    │   └───neovim: package 'nvim'
    ├───x86_64-darwin
    │   ├───default: package 'nvim'
    │   └───neovim: package 'nvim'
    └───x86_64-linux
        ├───default: package 'nvim'
        └───neovim: package 'nvim'
```
