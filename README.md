# Nix Configuration with Flakes

A modular Nix configuration supporting NixOS and macOS (Darwin).

## 🚀 Features

- **Multi-Platform**: NixOS, macOS (Darwin), and standalone Home Manager
- **Modular Architecture**: Organized with separate system and user configurations
- **Home Manager Integration**: User-specific package and configuration management
- **Dual Channel Support**: Both stable and unstable nixpkgs available

## 📁 Structure

```
.
├── flake.nix                    # Main flake configuration
├── darwin/                      # macOS-specific configurations
│   ├── default.nix             # Darwin system definitions
│   ├── darwin-configuration.nix # System-wide settings
│   └── home.nix                # User configurations
├── hosts/                       # NixOS host configurations
│   ├── configuration.nix       # Base configuration
│   ├── default.nix            # Host definitions
│   ├── devsystem/              # Development system
│   └── hp-pavilion/            # Laptop configuration
└── modules/                     # Shared modules
    ├── dev.nix                 # Development tools
    ├── theme.nix               # Theming
    ├── system-configs/         # System-level configs
    └── user-configs/           # User-level configs
```

## 🎯 Architecture

### Modular Design
- **System configurations**: Platform-specific system settings
- **User configurations**: Personal packages and dotfiles via Home Manager
- **Shared modules**: Reusable components across different hosts

## 🚀 Usage

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
darwin-rebuild switch --flake .#MacBookMChip
```

#### NixOS
```bash
git clone https://github.com/0xadeeb/Nix-config.git /etc/nixos
cd /etc/nixos
sudo nixos-rebuild switch --flake .#<hostname>
```

#### Home Manager Only
```bash
git clone https://github.com/0xadeeb/Nix-config.git ~/Nix-config
cd ~/Nix-config
home-manager switch --flake .#<username>
```

## ⚙️ Customization

### Adding New Hosts
1. Create configuration in `hosts/` (NixOS) or `darwin/` (macOS)
2. Add entry to respective `default.nix`
3. Reference in `flake.nix` outputs

### Package Management
- **System packages**: Edit `darwin-configuration.nix` or host-specific configs
- **User packages**: Modify `home.nix` or create user-specific configurations

## 🔧 Maintenance

```bash
# Update inputs
nix flake update

# Rebuild system
darwin-rebuild switch --flake .#<config>          # macOS
sudo nixos-rebuild switch --flake .#<config>      # NixOS

# Garbage collection
nix-collect-garbage -d
```

---

**Author**: 0xadeeb
