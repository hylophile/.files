hook global BufOpenFile .* recentf-add-file
hook global BufWritePost .* recentf-add-file

declare-option str recentf_file "%val{config}/.recentf"
declare-option int max_recentf_files 45

define-command -hidden recentf-add-file %{ nop %sh{
  	shortened_buffile=`sed "s#^$HOME#~#g" <<< "${kak_buffile}"`
    if ! grep -q "${shortened_buffile}" "${kak_opt_recentf_file}"; then
        printf "%s\n%s\n" "${shortened_buffile}" "$(cat ${kak_opt_recentf_file})" > ${kak_opt_recentf_file}
        printf "%s\n" "$(head -${kak_opt_max_recentf_files} ${kak_opt_recentf_file})" > ${kak_opt_recentf_file}
    fi
}}


define-command recentf2 -params 1 -shell-script-candidates %{ cat ${kak_opt_recentf_file} } %{ edit -existing %arg{1} }
define-command recentf %{
  prompt 'recentf:' -menu -shell-script-candidates %{ cat ${kak_opt_recentf_file} } %{
    edit -existing %val{text}
  }
}
