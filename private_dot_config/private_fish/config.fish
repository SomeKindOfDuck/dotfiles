if status is-interactive
    # Commands to run in interactive sessions can go here
end

pyenv init - | source
starship init fish | source

alias v "nvim"
alias e "exa"
alias el "exa -l"
alias ea "exa -a"
alias eal "exa -la"
alias tree "e -T"
alias fcd "cd (fd --type d --hidden . $HOME | fzf --height 40% --border)"
alias opj "cd (fd --type d --hidden . $HOME | fzf --height 40% --border) && v"

# exec exa -l and venv_exists just after cd
function cd
  builtin cd $argv; and exa -l
  venv_exists (pwd)
end

# if `.venv` exists in current directory, activate it
function venv_exists
  set dir $argv[1]
  if test $dir != /
    if test -d $dir/.venv
      set -gx PYTHON_VIRTUAL_ENV $dir/.venv/bin/activate.fish
      source $PYTHON_VIRTUAL_ENV
    else
      venv_exists (dirname $dir)
    end
  else
    if test -n "$PYTHON_VIRTUAL_ENV"
      deactivate
      set -e PYTHON_VIRTUAL_ENV
    end
  end
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/duck/.pyenv/versions/anaconda3-2024.10-1/bin/conda
    eval /home/duck/.pyenv/versions/anaconda3-2024.10-1/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/home/duck/.pyenv/versions/anaconda3-2024.10-1/etc/fish/conf.d/conda.fish"
        . "/home/duck/.pyenv/versions/anaconda3-2024.10-1/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/home/duck/.pyenv/versions/anaconda3-2024.10-1/bin" $PATH
    end
end
# Do not auto-activate conda base
if status is-interactive
    conda deactivate 2>/dev/null
end
# <<< conda initialize <<<

set -x QT_QPA_PLATFORM xcb
direnv hook fish | source
