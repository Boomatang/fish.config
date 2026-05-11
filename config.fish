set EDITOR /usr/bin/nvim
set FISH_USER_CLUSTER_CHECK 1

set -g fish_key_bindings fish_vi_key_bindings

set -gx GRAB_PATH $HOME/source

fish_add_path  /usr/local/go/bin
fish_add_path $HOME/bin $HOME/.poetry/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.local/share/JetBrains/Toolbox/scripts
fish_add_path $HOME/.opencode/bin

set -gx CONTAINER_TOOL podman
set -gx CONTAINER_ENGINE podman
# ZVM
set ZVM_INSTALL "$HOME/.zvm/self"
set -gx PATH "$PATH:$HOME/.zvm/bin"
set -gx PATH "$PATH:$ZVM_INSTALL/"

set -gx PYENV_ROOT $HOME/.pyenv

set KUBE_EDITOR nvim

pyenv init - | source
zoxide init fish | source

# Cluade code crap
set -gx CLAUDE_CODE_USE_VERTEX 1
set -gx CLOUD_ML_REGION us-east5
set -gx ANTHROPIC_VERTEX_PROJECT_ID itpc-gcp-hcm-pe-eng-claude
set -gx PATH "$PATH:$HOME/.npm-global/bin" 

set -gx HSA_OVERRIDE_GFX_VERSION 11.0.0
set -gx HIP_VISIBLE_DEVICES 0

if status is-interactive
    alias k kubectl

    alias gs "git status"
    alias ga "git add"
    alias gc "git commit -s"
    alias gb "git branch"
    alias gbc "git checkout"
    alias gd "git difftool --no-symlinks --dir-diff"

    alias kssh "kitty +kitten ssh"

    alias p 'nvim -c "set cole=1" -c "set filetype=markdown" -c "set runtimepath^=~/.config/nvim/lua/plugins/obsidian.lua" -c "ObsidianNew" '

    alias tree 'tree -C'

    alias h "bat -l cmd-help -Pp"

    test -d $PYENV_ROOT/bin; and fish_add_path $PYENV_ROOT/bin   # Commands to run in interactive sessions can go here

    pyenv init - fish | source
end
