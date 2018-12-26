^!u:: ; unfollow all your friends
WinGetActiveStats, Title, WinWidth, WinHeight, WinX, WinY
Loop 100 {
	Loop {
		ImageSearch, followingX, followingY, 0, 0, WinWidth, WinHeight, *50 images/following.png
		if (ErrorLevel = 0) {
			Click 70, 400
			Sleep 1000
			break
		}
	}
	Loop {
		ImageSearch, unfollow_closeX, unfollow_closeY, 0, 0, WinWidth, WinHeight, *50 images/unfollow_close.png
		if (ErrorLevel = 0) {
			Click 420, 770
			Sleep 1000
			break
		}
	}
	Loop {
		ImageSearch, unfollow2X, unfollow2Y, 0, 0, WinWidth, WinHeight, *50 images/unfollow2.png
		if (ErrorLevel = 0) {
			Click %unfollow2X%, %unfollow2Y%
			Sleep 1000
			break
		}
	}
	Loop {
		ImageSearch, unfollow_okX, unfollow_okY, 0, 0, WinWidth, WinHeight, *50 images/unfollow_ok.png
		if (ErrorLevel = 0) {
			Click %unfollow_okX%, %unfollow_okY%
			Sleep 1000
			break
		}
	}
}

^!p::pause ; pause script
^!r::Reload  ; reload script

^!t:: ; Test
ImageSearch, FoundX, FoundY, 0, 0, WinWidth, WinHeight, *10 images/unfollow.png
if (ErrorLevel = 0) {
	MsgBox Found image at %FoundX%, %FoundY%
}
else {
	MsgBox Could not find image
}
return