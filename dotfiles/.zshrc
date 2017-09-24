source ~/.zplug/init.zsh
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
#zplug "yous/lime"
zplug load --verbose

# Set up the prompt

autoload -Uz promptinit
promptinit

# 履歴管理
setopt histignorealldups sharehistory # <- history共有
export HISTCONTROL=erasedups
export HISTSIZE=10000
export HISTIGNORE=history:l:which
setopt HIST_IGNORE_SPACE
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(gdircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# =========================== Keybind
bindkey -v

# =========================== Aliases
alias l='ls -alFG'
alias vim='vim -O'
alias vi="gvim --remote-tab-silent"
alias o="open"
alias gb="git branch -a"
alias gs="git status"
alias gdiff="git diff"
alias gdiffo="git diff --no-ext-diff"
alias nw="sudo dhclient eth0 -r;sudo dhclient eth0"

alias readlink="greadlink"

# =========================== Functions
function up(){ cpath=./; for i in `seq 1 1 $1`; do cpath=$cpath../; done; cd $cpath;}
function glog(){ git log --decorate --stat $1 | vim -R - }
function glogp(){ git log --decorate -p $1 | vim -R - }

# autojump setting.
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# =========================== 環境変数
# grepハイライト設定
export GREP_OPTIONS='--color=auto'
export GREP_COLORS='fn=1;36:mt=1;31:ln=1;33'

# golang
export GOPATH=~/go

# ------------------------------------------------------------------------
# anyenv
# ------------------------------------------------------------------------
if [ -d ${HOME}/.anyenv ] ; then
  export PATH="$HOME/.anyenv/bin:$PATH"
  eval "$(anyenv init -)"
  for D in `ls $HOME/.anyenv/envs`
  do
      export PATH="$HOME/.anyenv/envs/$D/shims:$PATH"
  done
fi

# ~/bin
export PATH=$HOME/bin:$PATH 

# MacVim-KaoriYa
export PATH=/Applications/MacVim.app/Contents/bin:$PATH

# MacVim-KaoriYa
export PATH=/Applications/MacVim.app/Contents/bin:$PATH

# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH 

# =========================== VCS
# VCSの情報を取得するzshの便利関数 vcs_infoを使う
autoload -Uz vcs_info
# 表示フォーマットの指定
# %b ブランチ情報
# %a アクション名(mergeなど)
zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
# バージョン管理されているディレクトリにいれば表示，そうでなければ非表示
# 直前のコマンドの終了ステータスをプロンプト右に表示。
# RPROMPT="%1(v|%F{green}%1v%f|)"
autoload -U colors
colors
setopt promptsubst
PROMPT=$'[%~] \n%% '
RPROMPT="%* - %{$fg[black]%(?.$bg[green].$bg[red])%}<%?>%{$reset_color%} %1(v|%F{green}%1v%f|)"

# 環境依存設定の読み込み
source ~/.zshrc_local

# tmux自動起動
[[ -z "$TMUX" && ! -z "$PS1" ]] && tmux

export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"

# anyenv
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"
