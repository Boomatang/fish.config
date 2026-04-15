function project -d "Create a project directory in ~/Documents with a markdown file"
    argparse 'p' 'prefix=' -- $argv
    or return 1

    set -l project_name (string join ' ' $argv)

    if test -z "$project_name"
        echo "Usage: project [-p] [--prefix=VALUE] <project name...>" >&2
        return 1
    end

    set -l root $HOME/obsidian/PARA
    set -l projects "$root/1. Projects"

    # Determine prefix based on precedence
    set -l prefix
    if set -q _flag_prefix
        set prefix $_flag_prefix
    else if set -q _flag_p
        set prefix "P"
    else
        set prefix "RH"
    end

    # Build directory name
    set -l dir_name
    if test -n "$prefix"
        set dir_name "$prefix"_"$project_name"
    else
        set dir_name "$project_name"
    end

    set -l full_path "$projects/$dir_name"

    # Check if directory already exists
    if test -d "$full_path"
        echo "Error: Directory already exists: $full_path" >&2
        return 1
    end

    # Create directory
    mkdir -p "$full_path"
    or return 1

    # Create markdown file
    echo "# $project_name" > "$full_path/$dir_name.md"
    or return 1

    cd $root
    nvim -c "set cole=1" -c "set filetype=markdown" -c "set runtimepath^=~/.config/nvim/lua/plugins/obsidian.lua" "$full_path/$dir_name.md"

end
