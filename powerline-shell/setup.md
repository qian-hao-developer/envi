powerline-shell is like powerline but not powerline
maybe no load-slow problem

HP:
https://github.com/b-ryan/powerline-shell

setup:
* basically follow readme on HP
1. pip install powerline-shell
2. write to bashrc

function _update_ps1() {
    PS1=$(powerline-shell $?)
}
if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi
