function subs
    if ! test -n "$argv[1]"
        echo no arg! provide video file.
        return 1
    end
    set -l inp (fd srt | fzf --header "select srt input")
    set -l srt (echo $argv[1] | sed -E 's/(\.mp4$|\.mkv$)/.srt/')
    set -l outp (mktemp).srt
    set -l backupd (date --iso-8601=s | sed -E 's/(\:|\+)//g')
    if test -n "$inp" && test -n "$srt"
        set_color green
        echo uvx ffsubsync $argv[1] -i $inp -o $outp
        set_color normal
        uvx ffsubsync $argv[1] -i $inp -o $outp

        set_color green
        echo mv $srt .(basename $srt).backup.$backupd
        set_color normal
        mv $srt .(basename $srt).backup.$backupd

        set_color green
        echo mv $outp $srt
        set_color normal
        mv $outp $srt
    else
        echo fail
        return 1
    end
    set_color green
    echo done!
end
