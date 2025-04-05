#!/bin/bash
kitty -e tmux attach -t main || tmux new -s main
