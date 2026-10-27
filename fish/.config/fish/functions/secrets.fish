#Small plugin to help with easy decryption of secrets file as to never commit secrets to repos
function secrets
  if test "$argv[1]" = "open"
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
      echo "Usage: secrets [open|lock]"
  end
end
