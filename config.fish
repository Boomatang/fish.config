set EDITOR /usr/bin/nvim
set FISH_USER_CLUSTER_CHECK 1

set DOTFILES $HOME/code/github.com/Boomatang/dotfiles
set DOT_SCRIPTS $DOTFILES/scripts

set -g fish_key_bindings fish_vi_key_bindings

set -gx GRAB_PATH $HOME/source

set -gx PATH $PATH $HOME/bin $HOME/.poetry/bin
set -gx PATH $PATH $HOME/.local/bin
set -gx PATH $PATH $HOME/.cargo/bin
set -gx PATH $PATH $HOME/.local/share/JetBrains/Toolbox/scripts
set -gx PATH $PATH $HOME/.pyenv/bin
set -gx PATH $PATH /usr/local/go/bin
set -gx PATH $PATH $HOME/go/bin
set -gx PYENV_ROOT $HOME/.pyenv
set -gx LC_ALL en_GB.utf8

set -gx CLAUDE_CODE_USE_VERTEX 1
set -gx CLOUD_ML_REGION us-east5
set -gx ANTHROPIC_VERTEX_PROJECT_ID itpc-gcp-hcm-pe-eng-claude

set KUBE_EDITOR nvim

pyenv init - | source

if status is-interactive
    alias k kubectl

    alias gs "git status"
    alias ga "git add"
    alias gc "git commit -s"
    alias gb "git branch"
    alias gbc "git checkout"
    alias gd "git difftool --no-symlinks --dir-diff"

    alias kssh "kitty +kitten ssh"
    # Commands to run in interactive sessions can go here
end


# ZVM
set -gx ZVM_INSTALL "$HOME/.zvm/self"
set -gx PATH $PATH "$HOME/.zvm/bin"
set -gx PATH $PATH "$ZVM_INSTALL/"

# opencode
fish_add_path /home/boomatang/.opencode/bin
