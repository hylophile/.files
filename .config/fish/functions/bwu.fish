function bwu
set output (bw unlock)
set session_key (echo $output | sed 's/.*\(".*"\).*/\1/')
set -gx BW_SESSION $session_key
end
