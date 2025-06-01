# This script automatically activates a Python virtual environment
python_venv() {
  CHECK=./poetry.lock
  if [[ -f $CHECK ]]; then
    MYVENV=$(poetry env info -p 2> /dev/null)
  fi
  # when you cd into a folder that contains $MYVENV
  [[ -f $CHECK ]] && source $MYVENV/bin/activate > /dev/null 2>&1
  # when you cd into a folder that doesn't
  [[ ! -f $CHECK ]] && deactivate > /dev/null 2>&1
}

autoload -U add-zsh-hook
add-zsh-hook chpwd python_venv

