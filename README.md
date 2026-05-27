# nix-config

## file structure

```text
.
├── flake.nix
├── modules
│   ├── features            # the resuable modules
│   │   ├── common          # features shared by NixOS and Darwin (like Zsh and Tmux)
│   │   ├── darwin          # macOS specific features
│   │   └── nixos           # Linux specific features
│   └── hosts               # machine-specific configs
│       ├── christian-m2
│       └── asahi           # Asahi Linux host
└── data
```

- **Host-specific configs**: Each machine in `modules/hosts` chooses features by importing them from `inputs.self.sharedModules` (common) or `inputs.self.modules` (OS-specific).

## Usage

### Rebuild (Darwin)
```bash
sudo darwin-rebuild switch --flake .#christian-m2
```

### Rebuild (NixOS)
```bash
sudo nixos-rebuild switch --flake .#asahi
```

### Update
```bash
nix flake update
```

---

### Debugging
```bash
nix repl
nix-repl> :lf .
nix-repl> outputs.darwinConfigurations."christian-m2".config.system.defaults
```
