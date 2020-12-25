# -------------------------------------
# 環境変数
# -------------------------------------

# SSHで接続した先で日本語が使えるようにする
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# エディタ
export EDITOR=vim

# -------------------------------------
# zshのオプション
# -------------------------------------

# 補完機能の強化
autoload -Uz compinit && compinit -u

# 入力しているコマンド名が間違っている場合にもしかして：を出す。
setopt correct

# ビープを鳴らさない
setopt nobeep

# 色を使う
setopt prompt_subst

# リストの表示を詰める
setopt list_packed

# ^Dでログアウトしない。
setopt ignoreeof

# バックグラウンドジョブが終了したらすぐに知らせる。
setopt no_tify

# 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups

# 補完候補を一覧表示
setopt auto_list

# TAB で順に補完候補を切り替える
setopt auto_menu

# 補完候補一覧でファイルの種別をマーク表示
setopt list_types

# カッコの対応などを自動的に補完
setopt auto_param_keys

# cd -[tab]で過去のディレクトリにひとっ飛びできるようにする
setopt auto_pushd

# ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash

# 補完候補の色づけ
if [ -n "$LS_COLORS" ]; then
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi

# -------------------------------------
# プロンプト
# -------------------------------------

autoload -U promptinit; promptinit
autoload -Uz colors; colors
autoload -Uz vcs_info
autoload -Uz is-at-least

# begin VCS
zstyle ":vcs_info:*" enable git svn hg bzr
zstyle ":vcs_info:*" formats "(%s)-[%b]"
zstyle ":vcs_info:*" actionformats "(%s)-[%b|%a]"
zstyle ":vcs_info:(svn|bzr):*" branchformat "%b:r%r"
zstyle ":vcs_info:bzr:*" use-simple true

zstyle ":vcs_info:*" max-exports 6

if is-at-least 4.3.10; then
    zstyle ":vcs_info:git:*" check-for-changes true # commitしていないのをチェック
    zstyle ":vcs_info:git:*" stagedstr "<S>"
    zstyle ":vcs_info:git:*" unstagedstr "<U>"
    zstyle ":vcs_info:git:*" formats "(%b) %c%u"
    zstyle ":vcs_info:git:*" actionformats "(%s)-[%b|%a] %c%u"
fi

function vcs_prompt_info() {
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && echo -n " %{$fg[yellow]%}$vcs_info_msg_0_%f"
}
# end VCS

PREV_STATUS="%(?..[%?])"

PROMPT="%(?.%F{green}$PREV_STATUS%f.%F{red}$PREV_STATUS%f )"
PROMPT+="%F{blue}%~%f"
PROMPT+="\$(vcs_prompt_info)"
PROMPT+="
"
PROMPT+="%% "

# -------------------------------------
# キーバインド
# -------------------------------------

bindkey -e

bindkey "^R" history-incremental-search-backward

# zsh-history-substring-search up and down
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# -------------------------------------
# ヒストリー
# -------------------------------------

# 履歴ファイルの保存先
export HISTFILE=${HOME}/.zsh_history

# メモリに保存される履歴の件数
export HISTSIZE=10000

# 履歴ファイルに保存される履歴の件数
export SAVEHIST=50000

# 開始と終了を記録
setopt EXTENDED_HISTORY

# history (fc -l) コマンドをヒストリリストから取り除く。
setopt hist_no_store

# 履歴内の重複行を削除
setopt hist_ignore_all_dups

# Appends every command to the history file once it is executed
setopt inc_append_history

# Reloads the history whenever you use it
setopt share_history

# 全履歴の取得
function history-all { history -E 1 }

# -------------------------------------
# zplug
# -------------------------------------
source ~/.zplug/init.zsh

zplug 'zplug/zplug', \
    hook-build:'zplug --self-manage'

zplug 'jhawthorn/fzy', \
    as:command, \
    hook-build:'make'

zplug 'peco/peco', \
    as:command, \
    from:gh-r

zplug 'b4b4r07/enhancd', \
    use:init.sh

zplug 'zsh-users/zsh-history-substring-search'

zplug 'zsh-users/zsh-syntax-highlighting', \
    defer:2

zplug 'zsh-users/zsh-completions'

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf 'Install above zsh plugins? [y/N]:'
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load


export ENHANCD_FILTER="fzy:$ENHANCD_FILTER"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
