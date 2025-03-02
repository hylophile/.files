if command -q zoxide
    zoxide init fish --cmd d | source
end

if command -q direnv
    direnv hook fish | source
end

distrobox_auto_setup


function ls --wraps=lsd --description 'alias ls=lsd'
    lsd $argv
end

function ll --wraps='lsd -al' --description 'alias ll=lsd -al'
    lsd -al $argv
end

function llt --wraps='lsd -alrt' --description 'alias llt=lsd -alrt'
    lsd -alrt $argv
end


# bind \cW repaint
# bind \ch backward-kill-word
bind \ez 'disown; fish_prompt'
