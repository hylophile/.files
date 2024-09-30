set-option global swiper_cmd 'rg -in'
set-option global swiper_reduce_cmd 'rg -i'
set-face global Swiper green+r


declare-option str modeline_swiper ''

hook global WinSetOption (swiper_enabled=true|swiper_terms=.+) %{
  set-option buffer modeline_swiper "swiper (%opt{swiper_terms}){Default} "
}

hook global WinSetOption swiper_enabled=false %{
  set-option buffer modeline_swiper ''
}
