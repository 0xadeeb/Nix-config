# Nix Configuration

A modular, multi-platform Nix configuration utilizing `flake-parts`, `import-tree`, and a dendritic architecture.

## Features

- **Multi-Platform**: Supports NixOS and macOS.
- **Dendritic Architecture**: Feature-based folder structure organized by functional categories.
- **Flake Parts & Import Tree**: Simplified module loading and architecture scaling.
- **Profiles & Hosts**: Clear separation between core system settings (hosts) and user environments (profiles).
- **Home Manager Integration**: Integrated user-specific package and dotfile management.

## Structure

```text
.
├── flake.nix        # Main flake entrypoint using flake-parts
├── dotfiles/        # Raw configuration files
├── overlays/        # Custom package overlays and modifications
└── modules/         # Feature-based module tree loaded via import-tree
    ├── core/        # Core settings and foundational configurations
    ├── gui/         # Desktop environments and window managers
    ├── hardware/    # Hardware-specific configurations
    ├── hosts/       # Machine-specific entrypoints (system targets)
    ├── profiles/    # User roles and environment definitions
    ├── programs/    # User applications and CLI tools
    ├── services/    # System and user services
    ├── system/      # OS-level settings (networking, boot, etc.)
    └── theme/       # System-wide theming and styling
```

## Usage

### Prerequisites
```bash
# Install Nix with flakes
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

### Apply Configurations

#### macOS
```bash
git clone https://github.com/0xadeeb/Nix-config.git ~/Nix-config
cd ~/Nix-config
darwin-rebuild switch --flake .#<hostname>
```

#### NixOS
```bash
git clone https://github.com/0xadeeb/Nix-config.git /etc/nixos
cd /etc/nixos
sudo nixos-rebuild switch --flake .#<hostname>
```

## Customization

- **Dendritic Modules**: Add new features (programs, services, etc.) into their respective functional category under `modules/`.
- **Profiles**: Define user experiences or roles in `modules/profiles/`.
- **Hosts**: Create new machine configurations in `modules/hosts/` and import necessary profiles and core modules.

## Maintenance

```bash
# Update inputs
nix flake update

# Rebuild system
darwin-rebuild switch --flake .#<hostname>      # macOS
sudo nixos-rebuild switch --flake .#<hostname>  # NixOS

# Garbage collection
nix-collect-garbage -d
```
