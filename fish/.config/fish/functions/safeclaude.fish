function safeclaude --description 'Ensure sandboxed .claude/settings.local.json exists, then launch Claude Code'
    set -l config_dir .claude
    set -l config_file $config_dir/settings.local.json
    set -l expected '{
  "permissions": {
    "deny": [
      "Edit(~/.claude/settings.json)",
      "Edit(./.claude/settings.local.json)"
    ]
  },
  "sandbox": {
    "enabled": true,
    "allowUnsandboxedCommands": false,
    "filesystem": {
      "denyRead": ["~/"],
      "allowRead": [
        ".",
        "~/.bun",
        "~/.local/share/nvm",
        "~/.config/fish",
        "~/.claude/shell-snapshots"
      ],
      "denyWrite": [
        "~/.claude/settings.json",
        "./.claude/settings.local.json"
      ]
    }
  }
}'

    set -l needs_write 1
    if test -f $config_file
        if type -q jq
            # Semantic comparison: ignores whitespace/key-order differences
            set -l current (jq -S . $config_file 2>/dev/null | string collect)
            set -l want (printf '%s' $expected | jq -S . | string collect)
            if test -n "$current"; and test "$current" = "$want"
                set needs_write 0
            end
        else
            # Exact text comparison (trailing newline ignored)
            set -l current (cat $config_file | string collect)
            if test "$current" = "$expected"
                set needs_write 0
            end
        end
    end

    if test $needs_write -eq 1
        mkdir -p $config_dir; or return 1
        if test -e $config_file
            cp $config_file $config_file.bak
            echo "safeclaude: $config_file differed; backed up to $config_file.bak" >&2
        end
        printf '%s\n' $expected >$config_file; or return 1
        echo "safeclaude: wrote $config_file" >&2
    end

    command claude $argv
end
