
function kcluade
  argparse --ignore-unknown 't/tree=' -- $argv
  or return 1

  set -l plugin_path

  if set -q _flag_tree
    set plugin_path "$GRAB_PATH/github.com/Kuadrant/dev-team-plugin/$_flag_path"
  else
    git -C $GRAB_PATH/github.com/Kuadrant/dev-team-plugin fetch -p
    git -C $GRAB_PATH/github.com/Kuadrant/dev-team-plugin/main pull
    set plugin_path $GRAB_PATH/github.com/Kuadrant/dev-team-plugin/main
  end

  if path is filter --type dir "$plugin_path"
    claude --plugin-dir $plugin_path $argv
  else
    echo "plugin path not found: $plugin_path"
    return 1
  end
end
