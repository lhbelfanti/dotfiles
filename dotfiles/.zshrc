# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# ZSH Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Colors
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'
command -v lsd &> /dev/null && alias ls='lsd --group-dirs first'
command -v colorls &> /dev/null && alias ls='colorls --sd --gs'
command -v htop &> /dev/null && alias top='htop'
command -v gotop &> /dev/null && alias top='gotop -p'

# Plugins
plugins=(git
        z
        zsh-syntax-highlighting
        zsh-autosuggestions
        virtualenv
)

# Import zsh files
SCRIPTS="$HOME/.scripts"
source $SCRIPTS/functions.zsh # Loads source_if_exists and other functions

source_if_exists $SCRIPTS/exports.zsh
source_if_exists $SCRIPTS/p10k.zsh
source_if_exists $SCRIPTS/aliases.zsh

# Import sh files
source_if_exists $ZSH/oh-my-zsh.sh


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH="/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/3.0.0/bin:$PATH"

export PATH="/usr/local/opt/node@16/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
