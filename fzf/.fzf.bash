# Setup fzf
# ---------
if [[ ! "$PATH" == */home/linuxbrew/.linuxbrew/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/linuxbrew/.linuxbrew/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/linuxbrew/.linuxbrew/opt/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/linuxbrew/.linuxbrew/opt/fzf/shell/key-bindings.bash"

# Custom Setting
# ------------
## show fzf in split pane in tmux
export FZF_TMUX=1
## command completion (use **<TAB>) extra opts
## use fzf-tmux to support both tmux and bash
_fzf_comprun() {
    local command=$1
    shift

    case "$command" in
        cd)             fzf-tmux "$@" --preview 'tree -C {} | head -200' ;;
        export|unset)   fzf-tmux "$@" --preview "eval 'echo \$'{}" ;;
        ssh)            fzf-tmux "$@" --preview 'dig {}' ;;
        *)              fzf-tmux "$@" ;;
    esac
}
## CTRL_T additional opt
## preview file contents (use highlight or cat or tree)
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
## CTRL_R additional opt
## use '?' to toggle preview for the displayed command (usually used if the command is too long)
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
## ALT_C additional opt
## preview directory use tree
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
## Use fd instead of the default find
__fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" . "$1"
}
## Use fd to generate the list for directory completion
_fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . "$1"
}
