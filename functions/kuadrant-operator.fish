function kuadrant-operator
  if test "$argv[1]" = "-w"
      open https://github.com/kuadrant/kuadrant-operator
      return
  end
  if test "$argv[1]" = "-p"
      open https://github.com/kuadrant/kuadrant-operator/pulls/Boomatang
      return
  end
  if test "$argv[1]" = "--tidy"
  set -e ACK_GINKGO_DEPRECATIONS 
      return
  end
    
  cd $GRAB_PATH/github.com/Kuadrant/kuadrant-operator
  set -g ACK_GINKGO_DEPRECATIONS 2.11.0
  set -gx CONTAINER_ENGINE podman

  set_goroot
end
