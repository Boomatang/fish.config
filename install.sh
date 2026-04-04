#!/usr/bin/env bash
#
# Neovim Configuration Installation Script
# This script clones the neovim.config repository to ~/.config/nvim
# with automatic hostname-based branch selection.
#

set -euo pipefail

# Constants
REPO_URL="https://github.com/Boomatang/fish.config.git"
INSTALL_PATH="$HOME/.config/fish"
DEFAULT_BRANCH="main"

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

#######################################
# Print error message in red
# Arguments:
#   Message to print
#######################################
print_error() {
    echo -e "${RED}Error: $*${NC}" >&2
}

#######################################
# Print success message in green
# Arguments:
#   Message to print
#######################################
print_success() {
    echo -e "${GREEN}$*${NC}"
}

#######################################
# Print info message
# Arguments:
#   Message to print
#######################################
print_info() {
    echo -e "${BLUE}$*${NC}"
}

#######################################
# Print warning message in yellow
# Arguments:
#   Message to print
#######################################
print_warning() {
    echo -e "${YELLOW}Warning: $*${NC}"
}

#######################################
# Check if git is installed
# Exits with error if git is not found
#######################################
check_git_installed() {
    if ! command -v git &> /dev/null; then
        print_error "git is not installed"
        echo ""
        echo "Please install git before continuing:"
        echo "  - Debian/Ubuntu: sudo apt install git"
        echo "  - Fedora/RHEL:   sudo dnf install git"
        echo "  - Arch Linux:    sudo pacman -S git"
        echo "  - macOS:         brew install git"
        echo ""
        exit 1
    fi
}

#######################################
# Check if installation path already exists
# Exits with instructions if path exists
#######################################
check_existing_installation() {
    if [ -d "$INSTALL_PATH" ] || [ -f "$INSTALL_PATH" ]; then
        print_error "Installation path already exists: $INSTALL_PATH"
        echo ""
        echo "Please backup or remove your existing Neovim configuration before installing:"
        echo ""
        echo "  To backup (recommended):"
        echo "    mv $INSTALL_PATH $INSTALL_PATH.backup"
        echo ""
        echo "  To remove:"
        echo "    rm -rf $INSTALL_PATH"
        echo ""
        echo "Current contents:"
        ls -lah "$INSTALL_PATH" 2>/dev/null || echo "  (directory exists but cannot list contents)"
        echo ""
        exit 1
    fi
}

#######################################
# Determine which branch to use
# Checks if hostname matches a remote branch
# Returns: branch name to use (stdout)
# All messages go to stderr
#######################################
get_target_branch() {
    local hostname_value
    local branch="$DEFAULT_BRANCH"

    # Get hostname
    hostname_value=$(hostname)
    print_info "Detected hostname: $hostname_value" >&2

    # Query remote branches
    print_info "Checking available branches..." >&2
    local remote_branches
    if ! remote_branches=$(git ls-remote --heads "$REPO_URL" 2>&1); then
        print_warning "Could not query remote branches (network issue?)" >&2
        print_info "Using default branch: $DEFAULT_BRANCH" >&2
        echo "$DEFAULT_BRANCH"
        return
    fi

    # Check if hostname matches any branch
    # Format of ls-remote output: <hash> refs/heads/<branch-name>
    if echo "$remote_branches" | grep -q "refs/heads/$hostname_value$"; then
        branch="$hostname_value"
        print_success "Found branch matching hostname: $branch" >&2
    else
        print_info "No branch matching hostname '$hostname_value', using default: $DEFAULT_BRANCH" >&2
    fi

    echo "$branch"
}

#######################################
# Clone the repository
# Arguments:
#   Branch name to clone
#######################################
clone_repository() {
    local branch="$1"

    print_info "Cloning neovim configuration..."
    print_info "  Repository: $REPO_URL"
    print_info "  Branch:     $branch"
    print_info "  Target:     $INSTALL_PATH"
    echo ""

    # Create parent directory if needed
    mkdir -p "$(dirname "$INSTALL_PATH")"

    # Clone with specific branch
    if ! git clone --branch "$branch" "$REPO_URL" "$INSTALL_PATH"; then
        print_error "Failed to clone repository"
        echo ""
        echo "This could be due to:"
        echo "  - Network connectivity issues"
        echo "  - Invalid branch name"
        echo "  - Repository access problems"
        echo ""
        exit 1
    fi
}

#######################################
# Main installation function
#######################################
main() {
    echo ""
    print_info "========================================"
    print_info "  Neovim Configuration Installer"
    print_info "========================================"
    echo ""

    # Run pre-flight checks
    check_git_installed
    check_existing_installation

    # Determine target branch
    local target_branch
    target_branch=$(get_target_branch)
    echo ""

    # Clone repository
    clone_repository "$target_branch"

    # Success message
    echo ""
    print_success "========================================"
    print_success "  Installation Complete!"
    print_success "========================================"
    echo ""
    print_info "Next steps:"
    echo "  1. Launch Neovim: nvim"
    echo "  2. Plugins will automatically install on first launch"
    echo "  3. Wait for lazy.nvim to finish installing plugins"
    echo ""
    print_info "Configuration location: $INSTALL_PATH"
    echo ""
}

# Run main function
main "$@"
