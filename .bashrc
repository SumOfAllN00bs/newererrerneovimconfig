# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

cleanneovim() {
    rm -rf $HOME/.cache/nvim/
    rm -rf $HOME/.local/share/nvim/
    rm -rf $HOME/.local/state/nvim/
}

alias q=exit
alias :q=exit
alias ov=nvim
alias sov='sudo nvim'
alias v='NVIM_APPNAME=nvim-exp nvim'
alias sv='NVIM_APPNAME=nvim-exp sudo nvim'
alias l='ls -alh'
alias p=ipython
export EDITOR=nvim
