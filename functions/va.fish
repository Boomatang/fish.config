function va

  set -l root venv

  if test -e venv
    set root venv
  else if test -e .venv
    set root .venv
  else
    echo "no venv found"
    return
  end
    
  source $root/bin/activate.fish

end
