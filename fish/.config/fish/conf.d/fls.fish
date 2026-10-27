function fls
  if contains -- '-a' $argv
      fzf_with_icons "fd --hidden --exclude .git --max-depth 1" "cd" $FZF_PREVIEW_OPTS
  else
      fzf_with_icons "fd --exclude .git --max-depth 1" "cd" $FZF_PREVIEW_OPTS
  end
end
