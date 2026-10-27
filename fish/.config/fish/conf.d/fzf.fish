#fzf opts for funcs
set -gx FZF_PREVIEW_OPTS \
 --ansi \
 --layout=reverse \
 --preview "echo {} | sed 's/^.* //g' | xargs bat --color=always --plain --theme=ansi" \
 --preview-window "~3,noborder" \
 --color=16 \
 --bind 'ctrl-d:page-down,ctrl-u:page-up'

set -gx FZF_NO_PREVIEW_OPTS \
   --color=16 \
   --no-border \
   --layout=reverse \
   --bind 'ctrl-d:page-down,ctrl-u:page-up'

function fzf_with_icons
   set -l source_cmd $argv[1]
   set -l result_cmd $argv[2] 
   set -l fzf_opts $argv[3..-1]  
   
   # Run the pipeline with icons and preview
   set -l result (eval $source_cmd | devicon-lookup -i -p : | fzf $fzf_opts | sed 's/^.* //g')
   
   if test -n "$result"
       eval "$result_cmd '$result'"
   end
end
