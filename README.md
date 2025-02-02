# Eliah Reeves dotfiles

My dotfiles to configure an editor in Ubuntu and other Unix-like systems.

## Linux Usage

I made these to work with stow. To configure a tool simply run:

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
