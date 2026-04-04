function docs.kuadrant.io
    
  if test "$argv[1]" = "-w"
      open https://github.com/kuadrant/docs.kuadrant.io
      return
  end

  if test "$argv[1]" = "-p"
      open https://github.com/kuadrant/docs.kuadrant.io/pulls/Boomatang
      return
  end

  cd $HOME/code/github.com/Kuadrant/docs.kuadrant.io
    
end
