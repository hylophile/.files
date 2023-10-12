function ls --wraps=lsd --description 'alias ls=lsd'
    if command -v lsd >/dev/null
        lsd $argv
    else
        command ls --color $argv
    end
end
