^!f:: ; follow all friends from a given list of friend codes
WinGetActiveStats, Title, WinWidth, WinHeight, WinX, WinY
file_name := "terra_asb_codes.txt"
file := FileOpen(file_name, "r")
if !IsObject(file)
{
	MsgBox Can't open "%file_name%" for reading.
	return
}

Loop 100{
	line := file.ReadLine()
	line_arr := StrSplit(line, ",")
	friend_code := line_arr[1]
	Loop {
		ImageSearch, searchX, searchY, 0, 0, WinWidth, WinHeight, *50 images/search.png
		ImageSearch, search2X, search2Y, 0, 0, WinWidth, WinHeight, *50 images/search2.png
		if (searchX > 0 or search2X > 0) {
			Click 150, 450
			Sleep 1000
			break
		}
	}
	Send {BS}{BS}{BS}{BS}
	Sleep 1000
	Send %friend_code%
	Sleep 500
	Send {enter}
	Sleep 1000
	Loop {
		ImageSearch, searchX, searchY, 0, 0, WinWidth, WinHeight, *50 images/search.png
		if (ErrorLevel = 0) {
			Click %searchX%, %searchY%
			Sleep 1000
			break
		}
	}
	Loop {
		ImageSearch, search_closeX, search_closeY, 0, 0, WinWidth, WinHeight, *50 images/search_close.png
		if (ErrorLevel = 0) {
			Click 420, 770
			Sleep 1000
			break
		}
	}
	Sleep 1000	
}

^!p::pause ; pause script
^!r::Reload  ; reload script

^!t:: ; Test
ImageSearch, FoundX, FoundY, 0, 0, WinWidth, WinHeight, *50 images/search.png
if (ErrorLevel = 0) {
	MsgBox Found image at %FoundX%, %FoundY%
}
else {
	MsgBox Could not find image
}
return