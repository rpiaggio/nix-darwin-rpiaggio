# Some ideas taken from https://github.com/gazorby/fish-exa
# and https://github.com/renovate-bot/z-shell-_-zsh-eza

builtin emulate -L zsh ${=${options[xtrace]:#off}:+-o xtrace}
builtin setopt extended_glob warn_create_global typeset_silent

if (( $+commands[eza] )); then
  typeset enable_autocd=0
  typeset -a eza_params

  # Keep in variable for printing help. --long could be included here.
  # Not sure --group-directories-first is best when using --tree
  eza_params=(
    '--group-directories-first' '--git'
    '--time-style=long-iso' '--color-scale=all'
  )

  alias l=eza
  alias ll="eza --long $eza_params"
  alias le="eza --long --extended $eza_params"
  alias lm="ll --sort newest"
  alias lM="ll --sort oldest"
  alias lz="ll --sort size"
  alias lZ="ll --sort size --reverse"
  #alias lt="eza --tree --level"

  # add the -all
  for base in l ll le lm lM lz lZ; do
    alias ${base}a="$base --all";
    list+=(${base}a);
  done

  # only the l and ll variants get the rest of the suffixes
  typeset -a list=(l la ll lla)

  # add --git-ignore
  for base in ${list[@]}; do 
    alias ${base}g="$base --git-ignore";
    list+=(${base}g);
  done

  # add --tree --tree-level (must be last)
  for base in ${list[@]}; do 
    alias ${base}t="$base --tree --level"
  done

  # Might be a better way to print this with markdown?
  function lh {
    help=$(cat <<EOT
 Base commands:
   l    exa
   ll   exa --long ${eza_params}
   le   ll --extended
   lm   ll --sort newest
   lM   ll --sort oldest
   lz   ll --sort size
   lZ   ll --sort size --reverse
 To the above, these suffixes can be added, in order
   a    adds --all
   g    adds --git-ignore (only for l and ll variants)
   t    adds --tree --level (only for l and ll variants, must add level)
 Helpful options
   -a, -all   Added a second time includes . and ..
   --icons
   -D, --only-dirs
   -f, --only-files
   -g, --group
   -h, --header
EOT
    )
    echo $help
  }

  # unset eza_params
  unset list

else
  print "Please install eza before using this plugin." >&2
  return 1
fi

return 0
