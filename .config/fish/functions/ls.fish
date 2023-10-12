function ls --wraps=lsd --description 'alias ls=lsd'
    if command -v lsd
        lsd $argv
    else
        builtin ls $argv
    end
end
