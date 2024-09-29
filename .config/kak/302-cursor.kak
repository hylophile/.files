set-face global PrimaryCursorNormal black,cyan
set-face global PrimaryCursorInsert black,magenta
set-face global PrimaryCursor PrimaryCursorNormal

set-face global PrimaryCursorEolNormal black,white
set-face global PrimaryCursorEolInsert black,magenta
set-face global PrimaryCursorEol PrimaryCursorEolNormal 

set-face global PrimarySelection default,bright-black
set-face global SecondaryCursor black,white
set-face global SecondarySelection default,bright-black
set-face global SecondaryCursorEol black,white

# enter insert mode
hook global ModeChange (push|pop):.*insert %{
	set-face window PrimaryCursor PrimaryCursorInsert
	set-face window PrimaryCursorEol PrimaryCursorEolInsert
}

# back to normal
hook global ModeChange (push|pop):insert:.* %{
	set-face window PrimaryCursor PrimaryCursorNormal
	set-face window PrimaryCursorEol PrimaryCursorEolNormal
}
