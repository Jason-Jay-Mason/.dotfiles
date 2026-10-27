#INFO: fish theme and styling
set fish_greeting
# Icons for hydro theme https://github.com/jorgebucaran/hydro
switch (uname -s)
  case "Linux"
    set --global hydro_symbol_prompt 'λ '
  case "Darwin"
    set --global hydro_symbol_prompt 'λ'
end

set --global hydro_symbol_git_dirty ' ≠ '
set --global hydro_symbol_git_ahead '↑  '
set --global hydro_symbol_git_behind '↓  '
set --global hydro_color_pwd green
set --global hydro_color_prompt cyan
