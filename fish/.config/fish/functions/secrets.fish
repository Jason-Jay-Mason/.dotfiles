#Small plugin to help with easy decryption of secrets file as to never commit secrets to repos
function secrets
  if test "$argv[1]" = "init"
      # Refuse to clobber an existing secrets file
      if test -f "secrets.open.yml"; or test -f "secrets.locked.yml"
          echo "Error: secrets file already exists in current directory"
          return 1
      end

      if test -f ".gitignore"
          # Add secrets.open.yml to .gitignore unless it's already there
          if not grep -qxF "secrets.open.yml" .gitignore
              # Make sure the entry lands on its own line
              if test -n "$(tail -c1 .gitignore)"
                  echo "" >> .gitignore
              end
              echo "secrets.open.yml" >> .gitignore
              echo "Added secrets.open.yml to .gitignore"
          end
      else
          set_color red
          echo "No .gitignore in this directory. Your secrets could be vulnerable if you push to a repo!"
          set_color normal
          read -l -P "Create .gitignore in this dir to mitigate this? [y/N] " answer
          if string match -qir '^(y|yes)$' -- "$answer"
              echo "secrets.open.yml" > .gitignore
              echo "Created .gitignore with secrets.open.yml ignored"
          end
      end

      touch secrets.open.yml
      echo "Created secrets.open.yml"
  else if test "$argv[1]" = "open"
      # Check if secrets.locked.yml exists in current directory
      if test -f "secrets.locked.yml"
          # Run ansible-vault decrypt and capture the exit status
          ansible-vault decrypt secrets.locked.yml
          set -l decrypt_status $status
          
          # If the command was successful (exit status 0), rename the file
          if test $decrypt_status -eq 0
              mv secrets.locked.yml secrets.open.yml
              echo "Successfully decrypted and renamed to secrets.open.yml"
          else
              echo "Decryption failed. File name remains unchanged."
          end
      else
          echo "Error: secrets.locked.yml not found in current directory"
      end
  else if test "$argv[1]" = "lock"
      # Check if secrets.open.yml exists in current directory
      if test -f "secrets.open.yml"
          # Run ansible-vault encrypt and capture the exit status
          ansible-vault encrypt secrets.open.yml
          set -l encrypt_status $status
          
          # If the command was successful (exit status 0), rename the file
          if test $encrypt_status -eq 0
              mv secrets.open.yml secrets.locked.yml
              echo "Successfully encrypted and renamed to secrets.locked.yml"
          else
              echo "Encryption failed. File name remains unchanged."
          end
      else
          echo "Error: secrets.open.yml not found in current directory"
      end
  else
      echo "Usage: secrets [init|open|lock]"
  end
end
