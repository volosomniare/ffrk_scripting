^!f:: ; follow all friends from a given list of friend codes
WinGetActiveStats, Title, WinWidth, WinHeight, WinX, WinY
file_name := "roaming_warriors/pusb1.csv"
file := FileOpen(file_name, "r")
if !IsObject(file)
{
	MsgBox Can't open "%file_name%" for reading.
	return
}
eof := 0
while (eof = 0) {
	line := file.ReadLine()
	line_arr := StrSplit(line, ",")
	friend_code := line_arr[1]
	Loop 10{
		ImageSearch, searchX, searchY, 0, 0, WinWidth, WinHeight, *50 images/search.png
		ImageSearch, search2X, search2Y, 0, 0, WinWidth, WinHeight, *50 images/search2.png
		if (searchX > 0 or search2X > 0) {
			Click 150, 450
			Sleep 300
			break
		}
		Sleep 100
	}
	Send {BS}{BS}{BS}{BS}
	Sleep 300
	Send %friend_code%
	Sleep 300
	Send {enter}
	Sleep 300
	Loop 10{
		ImageSearch, searchX, searchY, 0, 0, WinWidth, WinHeight, *50 images/search.png
		if (searchX > 0) {
			Click %searchX%, %searchY%
			Sleep 300
			break
		}
		Sleep 100
	}
	Loop 10{
		ImageSearch, unfollowX, unfollowY, 0, 0, WinWidth, WinHeight, *50 images/unfollow.png
		ImageSearch, search_closeX, search_closeY, 0, 0, WinWidth, WinHeight, *50 images/search_close.png
		if (unfollowX > 0) {
			break 2
		}
		if (search_closeX > 0) {
			Click 420, 770
			Sleep 300
			break
		}
		Sleep 100
	}
	Sleep 300
	eof = file.AtEOF
}
ExitApp

^!p::pause ; pause script
^!r::Reload  ; reload script

^!t:: ; Test
WinGetActiveStats, Title, WinWidth, WinHeight, WinX, WinY
ImageSearch, FoundX, FoundY, 0, 0, WinWidth, WinHeight, *10 images/unfollow.png
if (ErrorLevel = 0) {
	MsgBox Found image at %FoundX%, %FoundY%
}
else {
	MsgBox Could not find image
}
return