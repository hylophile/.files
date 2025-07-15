function watch
    mpv (fd $argv[1] /mnt/media/new-dls/ --full-path --type file --extension mkv --extension mp4 | sed 's#^/mnt/media/new-dls/##' | fzf --cycle --exact --header=\n(,series $argv[1])\n\n | sed 's#^#/mnt/media/new-dls/#')
end
