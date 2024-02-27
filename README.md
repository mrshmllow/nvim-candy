# Neovim Config

Neovim config for myself

```bash 
nix run github:mrshmllow/nvim-candy
```

- Attempts to rely on as few plugins as possible
- `APPNAME=candy` as to not cause conflicts
- all custom lua is under the `require("marshmallow\..*")` space

## Output

```
git+file:///home/marsh/.config/nvim
├───defaultPackage
│   ├───aarch64-darwin omitted (use '--all-systems' to show)
│   ├───aarch64-linux omitted (use '--all-systems' to show)
│   ├───x86_64-darwin omitted (use '--all-systems' to show)
│   └───x86_64-linux: package 'neovim-XXXXXXX'
├───herculesCI: unknown
├───overlay: Nixpkgs overlay
├───overlays
│   └───default: Nixpkgs overlay
└───packages
    ├───aarch64-darwin
    │   ├───default omitted (use '--all-systems' to show)
    │   └───neovim omitted (use '--all-systems' to show)
    ├───aarch64-linux
    │   ├───default omitted (use '--all-systems' to show)
    │   └───neovim omitted (use '--all-systems' to show)
    ├───x86_64-darwin
    │   ├───default omitted (use '--all-systems' to show)
    │   └───neovim omitted (use '--all-systems' to show)
    └───x86_64-linux
        ├───default: package 'neovim-XXXXXXX'
        └───neovim: package 'neovim-XXXXXXX'
```
