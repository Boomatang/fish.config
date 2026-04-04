# fish.config

A comprehensive [Fish shell](https://fishshell.com/) configuration tailored for development workflows, particularly focused on Kubernetes, Go, Python, and Rust development. Features custom prompts, aliases, functions, and completions for a streamlined command-line experience.

## Features

### Custom Prompt
- **Git integration**: Shows current branch and repository status
- **Kubernetes cluster info**: Displays active cluster and connection status
- **Time and directory**: Clean, informative prompt layout

### Development Aliases
- **Git shortcuts**: `gs` (status), `ga` (add), `gc` (commit), `gb` (branch), `gbc` (create branch), `gd` (diff)
- **Kubernetes**: `k` (kubectl alias)
- **Kitty terminal**: SSH integration with `kitty +kitten ssh`

### Custom Functions (25+)
Specialized functions for development workflows:
- **Kubernetes/Kuadrant projects**: Quick navigation to `kuadrant-operator`, `authorino`, `limitador`, `policy-machinery`, and their respective operator repos
- **Cluster info**: `current_cluster` - Show active Kubernetes cluster with status
- **Utilities**: `bass` (run bash scripts in fish), `set_goroot`, directory helpers, file size utilities, and more

### Tab Completions
Pre-configured completions for:
- **Kubernetes**: `kubectl`, `kind`, `oc` (OpenShift), `ocm`
- **Package managers**: `poetry`, `pipx`
- **Cloud tools**: `hcloud`

### Environment Configuration
Sets up development paths and variables for:
- **Languages**: Go (GOPATH, GOROOT), Python (PyEnv), Rust (Cargo)
- **Editors**: Neovim as default editor
- **Tools**: Poetry, JetBrains IDEs, Zig Version Manager (ZVM)
- **Cloud**: Vertex AI, Anthropic configuration
- **UTF-8 locale**: Proper character encoding

### VI Key Bindings
Familiar vim-style navigation in the command line.

## Installation

### Prerequisites
- [Fish shell](https://fishshell.com/) installed
- Git

### Install with curl

Run the following command to automatically install this configuration to `~/.config/fish`:

```bash
curl -fsSL https://raw.githubusercontent.com/Boomatang/fish.config/main/install.sh | bash
```

#### Hostname-Based Branch Selection

The installer automatically checks for a branch matching your hostname. If a matching branch exists in the repository, it will be cloned instead of the `main` branch. This allows for machine-specific configurations.

**Example:**
- Hostname: `workstation`
- If a branch named `workstation` exists, it will be cloned
- Otherwise, the `main` branch is used

### Post-Installation

After installation:
1. Restart your shell or run:
   ```bash
   exec fish
   ```
2. Your custom configuration will be active immediately

## What Gets Configured

### Environment Variables
- `EDITOR`: Set to `nvim` (Neovim)
- `GOPATH`, `GOROOT`: Go development paths
- `PYENV_ROOT`: Python version management
- `KUBE_EDITOR`: Kubernetes resource editor
- Various PATH additions for development tools

### Key Bindings
- VI mode for command-line editing

## Uninstallation

To remove this configuration:

```bash
# Backup first (recommended)
mv ~/.config/fish ~/.config/fish.backup

# Or remove completely
rm -rf ~/.config/fish
```

Then restart your shell to return to default Fish configuration.

## Repository Structure

```
.
├── config.fish              # Main configuration file
├── functions/               # Custom functions (25+ utilities)
│   ├── fish_prompt.fish     # Custom prompt with git/k8s info
│   ├── current_cluster.fish # Kubernetes cluster status
│   └── ...                  # Project navigation and dev helpers
├── completions/             # Tab completion definitions
│   ├── kubectl.fish
│   ├── poetry.fish
│   └── ...                  # 9 completion files
└── conf.d/                  # Additional configuration
    └── rustup.fish          # Rust environment setup
```

## License

Personal configuration - use and modify as needed.