rg -i "^Name=.*ste.*" /usr/share/applications/*.desktop ~/.local/share/applications/*.desktop |
  while read -r line; do
    file=$(echo "$line" | cut -d: -f1)
    echo "File: $file"
    rg -i "^Name=" "$file"
    rg -i "^Icon=" "$file"
    rg -i "^Exec=" "$file"
    echo ""
  done
