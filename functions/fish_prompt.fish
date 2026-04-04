function fish_prompt --description 'Write out the prompt'
    set -l last_status $status
    set -l normal (set_color normal)
    set -l status_color (set_color brgreen)
    set -l cwd_color (set_color $fish_color_cwd)
    set -l vcs_color (set_color brpurple)
    set -l prompt_status ""

    set -g __fish_git_prompt_showdirtystate 1
    set -g __fish_git_prompt_showuntrackedfiles 1
    set -g __fish_git_prompt_showupstream informative
    set -g __fish_git_prompt_showcolorhints 1
    set -g __fish_git_prompt_use_informative_chars 1
    # Unfortunately this only works if we have a sensible locale
    string match -qi "*.utf-8" -- $LANG $LC_CTYPE $LC_ALL
    and set -g __fish_git_prompt_char_dirtystate \U1F4a9
    set -g __fish_git_prompt_char_untrackedfiles "?"

    string match -qi "*.utf-8" -- $LANG $LC_CTYPE $LC_ALL
    and set -g __fish_git_prompt_char_untrackedfiles \U2754

    set -l lgb (set_color brgreen) [ (set_color normal)
    set -l rgb (set_color brgreen) ] (set_color normal)
    set -l d (set_color brred)(date "+%R")(set_color normal)
    # set -l time_label (set_color brgreen) [ (set_color normal)$d(set_color brgreen)](set_color normal)
    set -l time_label $lgb $d $rgb

    # Color the prompt differently when we're root
    set -l suffix '->'
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set cwd_color (set_color $fish_color_cwd_root)
        end
        set suffix '#'
    end

    # Color the prompt in red on error
    if test $last_status -ne 0
        set status_color (set_color $fish_color_error)
        set prompt_status $status_color "[" $last_status "]" $normal
    end

    set -l prompt $time_label ' ' $lgb $cwd_color (prompt_pwd) $vcs_color (fish_vcs_prompt) $normal $rgb 

    if test $FISH_USER_CLUSTER_CHECK -eq 1
      set -l cc (current_cluster)
      if test -n "$cc"
        set value $lgb $cc $rgb
        set prompt $prompt ' ' $value
      end
    end


    echo -s $prompt ' ' $prompt_status
    echo -n -s $status_color $suffix ' ' $normal
end
