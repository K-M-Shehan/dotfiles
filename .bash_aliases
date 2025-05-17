# some aliases i setup for ease

# Reload bashrc
alias reload='source ~/.bashrc'

alias ..='cd ..'
alias la='ls -al'
alias c='clear'
alias clip='xclip -selection clipboard <'

# -----------------------
# 🧪 GIT HELPERS
# -----------------------
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'

# apps
alias zen="flatpak run app.zen_browser.zen"

# fzf aliases
alias f='fzf --preview="cat {}"'
alias fv='vim $(fzf -m --preview="cat {}")'
