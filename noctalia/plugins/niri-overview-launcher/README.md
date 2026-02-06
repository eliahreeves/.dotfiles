# Niri Overview Launcher

A Noctalia plugin that automatically opens the launcher when you start typing in niri's overview mode.

## Features

- Detects when niri's overview mode is active
- Captures keyboard input when in overview mode
- Opens the Noctalia launcher (`qs -c noctalia-shell ipc call launcher toggle`) when you type any text
- Ignores special keys, modifiers, and navigation keys so they still work in overview mode

## Requirements

- Noctalia 4.1.2 or higher
- Niri window manager
- The niri socket must be available via `$NIRI_SOCKET` environment variable

## Installation

1. Copy this plugin directory to your Noctalia plugins folder
2. Restart Noctalia or reload plugins
3. The plugin will automatically activate when using niri

## Usage

1. Enter niri's overview mode (usually with `Mod+Tab` or your configured keybinding)
2. Start typing - the launcher will automatically open
3. The launcher will be pre-filled with your typed character

## How it works

The plugin:
1. Connects to niri's event stream via the niri socket
2. Monitors for `OverviewOpenedOrClosed` events
3. When overview mode is active, creates transparent overlay windows on all screens
4. These windows capture keyboard focus but are click-through
5. When you type a regular character (not a special key), it executes the launcher toggle command

## Credits

Inspired by the implementation in [DankMaterialShell](https://github.com/AvengeMedia/DankMaterialShell)
