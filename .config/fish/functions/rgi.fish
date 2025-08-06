function rgi --wraps='rg --smart-case' --description 'alias rgi rg --smart-case'
    rg --vimgrep --smart-case $argv
end
