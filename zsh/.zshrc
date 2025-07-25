if [ -z "$TMUX" ] && [ "$TERM_PROGRAM" != "vscode" ]; then tmux attach -t main || tmux new -s main; fi
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PAGER="nvim +Man\!"
export EDITOR="nvim"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

alias rcat="command cat"
alias cat="bat"

alias android="QT_QPA_PLATFORM=xcb nohup ~/Programs/Android/Sdk/emulator/emulator -avd Pixel_9_Pro_XL >/dev/null 2>&1 &"


export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST
source $ZSH/oh-my-zsh.sh

autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# My path
export PATH=$PATH:~/.cargo/bin
# CSE293 + CSE225 fpga until
# export PATH=$PATH:~/Programs/fpga-utils/oss-cad-suite/bin
# export PATH=$PATH:~/Programs/fpga-utils/zachjs-sv2v
# export PATH=$PATH:~/Programs/fpga-utils/verible-v0.0-3946-g851d3ff4/bin
# export PATH=$PATH:~/Programs/fpga-utils/xschem/bin
# export PATH=$PATH:~/Programs/fpga-utils/netgen/bin
# export PATH=$PATH:~/Programs/fpga-utils/slang-lsp-tools/build
# export PATH=$PATH:~/Programs/fpga-utils/slang/build/bin
# export PDK_ROOT=~/.volare

# dev() {
#   local repo_root
#   repo_root=$(git rev-parse --show-toplevel) || return 1
#
#   local rel_path
#   rel_path=$(git rev-parse --show-prefix)
#
#   devcontainer up --workspace-folder "$repo_root" || return 1
#
#   devcontainer exec --workspace-folder "$repo_root" /bin/bash -c "cd '$rel_path' && exec /bin/bash"
# }



# Flutter
export CHROME_EXECUTABLE=$(which brave)
export PATH=$PATH:~/Programs/flutter/bin
export PATH=$PATH:~/Programs/Android/Sdk/platform-tools


# ESP32
# alias idf-activate="source ~/Programs/esp/esp-idf/export.sh"

# MATLAB
# export PATH=$PATH:/usr/local/MATLAB/R2024b/bin
# export PATH=$PATH:~/Programs/matlab/bin
# run_matlab() {
#   if [[ -z "$1" ]]; then
#     echo "Usage: run_matlab <file_path>"
#     return 1
#   fi
#   matlab -nodisplay -r "run('$1'); exit;"
# }
# alias matlab-run=run_matlab
#
# # nvm(node/npm)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/erreeves/Programs/gsutil/path.zsh.inc' ]; then . '/home/erreeves/Programs/gsutil/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/erreeves/Programs/gsutil/completion.zsh.inc' ]; then . '/home/erreeves/Programs/gsutil/completion.zsh.inc'; fi

eval "$(zoxide init zsh)"
