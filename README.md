# dotfiles

## Linux Usage

Most configurations are made for GNU stow. To configure a tool simply run:

```bash
stow <NAME_OF_TOOL>
```

Example:

```bash
stow nvim
```

## Windows Usage

```PowerShell
New-Item -ItemType SymbolicLink -Path $env:LOCALAPPDATA\nvim -Target "C:\Users\ereec\.dotfiles\nvim\.config\nvim\"
```
