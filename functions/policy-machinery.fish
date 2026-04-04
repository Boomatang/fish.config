function policy-machinery
  if test "$argv[1]" = "-w"
      open https://github.com/kuadrant/policy-machinery
      return
  end
  if test "$argv[1]" = "-p"
      open https://github.com/kuadrant/policy-machinery/pulls/Boomatang
      return
  end
    
  cd $GRAB_PATH/github.com/Kuadrant/policy-machinery

  set_goroot
end
