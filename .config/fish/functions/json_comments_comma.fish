function json_comments_comma --wraps='prettier --parser json5 --quote-props preserve' --description 'alias json_comments_comma=prettier --parser json5 --quote-props preserve'
  prettier --parser json5 --quote-props preserve $argv; 
end
