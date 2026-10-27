# Air is a hot reload for go
# alias air="~/go/bin/air"
alias n="nvim"

#logo ls instead of ls and ll; we like logos around here
function ls
    logo-ls $argv
end
function ll
    command logo-ls -l 
end
