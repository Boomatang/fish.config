function mv_to_para
    set -l src $argv[1]
    if test -z "$src"
        echo "Usage: mv_to_para /path/from/destination"
        return 1
    end

    find $src -maxdepth 1 -regextype posix-extended -regex ".*[0-9]{10}-[A-Z]{4}\.md" -exec mv -v {} $HOME/obsidian/PARA/ \;
end
