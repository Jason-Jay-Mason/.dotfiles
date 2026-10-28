function safeclaude --description 'Ensure sandboxed .claude/settings.local.json exists, then launch Claude Code'
    set -l config_dir .claude
    set -l config_file $config_dir/settings.local.json
    set -l expected '{
  "permissions": {
    "deny": [
      "Edit(~/.claude/settings.json)",
      "Edit(./.claude/settings.local.json)",
      "Read(**/.env)",
      "Edit(**/.env)",
      "Write(**/.env)",
      "Read(**/.env.local)",
      "Edit(**/.env.local)",
      "Write(**/.env.local)",
      "Read(**/.env.*.local)",
      "Edit(**/.env.*.local)",
      "Write(**/.env.*.local)",
      "Read(**/.env.development)",
      "Edit(**/.env.development)",
      "Write(**/.env.development)",
      "Read(**/.env.production)",
      "Edit(**/.env.production)",
      "Write(**/.env.production)",
      "Read(**/.env.staging)",
      "Edit(**/.env.staging)",
      "Write(**/.env.staging)",
      "Read(**/.env.test)",
      "Edit(**/.env.test)",
      "Write(**/.env.test)"
    ]
  },
  "hooks":{
    "PreToolUse": [
      {
        "matcher": "Read|Write|Edit|MultiEdit|NotebookEdit|Grep|Glob|Bash",
        "hooks": [
          {
            "type": "command",
            "command": "python3 ~/.claude/hooks/block-env-files.py"
          }
        ]
      }
    ]
  },
  "sandbox": {
    "enabled": true,
    "allowUnsandboxedCommands": false,
    "filesystem": {
      "denyRead": ["~/", "./.env"],
      "allowRead": [
        ".",
        "~/.bun",
        "~/.local/share/nvm",
        "~/.config/fish",
        "~/.claude/shell-snapshots",
        "~/.alchemy",
        "~/.local/state/alchemy",
        "~/.cache/assets"
      ],
      "allowWrite": [
        "~/.alchemy",
        "~/.local/state/alchemy",
        "~/.cache/assets"
      ]
    },
   "network": {
        "allowLocalBinding": true,
        "allowedDomains": [
          "api.cloudflare.com",
          "*.argotunnel.com",
          "*.cftunnel.com"
        ]
    }
  }
}
    '

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
