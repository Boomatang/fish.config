function authorino
    
  if test "$argv[1]" = "-w"
      open https://github.com/kuadrant/authorino
      return
  end

  if test "$argv[1]" = "-p"
      open https://github.com/kuadrant/authorino/pulls/Boomatang
      return
  end

  cd $GRAB_PATH/github.com/Kuadrant/authorino

  set_goroot
    
end
