
function authorino-operator
     
  if test "$argv[1]" = "-w"
      open https://github.com/kuadrant/authorino-operator
      return
  end

  if test "$argv[1]" = "-p"
      open https://github.com/kuadrant/authorino-operator/pulls/Boomatang
      return
  end
   
  cd $GRAB_PATH/github.com/Kuadrant/authorino-operator

  set_goroot
    
end
