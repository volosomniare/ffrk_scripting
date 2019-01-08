; constant initialization and function definitions 
^!c:: ; initialize constants
WinGetActiveStats, Title, WinWidth, WinHeight, WinX, WinY
sel2 := [480, 630]
sel3 := [480, 770]

att := [50, 840]
def := [150, 840]
ab1 := [250, 840]
ab2 := [350, 840]
sb := [480, 840]
rw := [180, 700]
mag := [300, 700]

char_counter := {}
run_counter := 0
total_run_counter := 0
total_run_counter_pos := 0
green_counter := 0
green_counter_pos := 0
skip_friends := 0

char_abils := {}
char_orders := {}

FindImageAndClick(images*) {
	global WinWidth
	global WinHeight
	Loop {
		for idx, image in images {
			ImageSearch imgX, imgY, 0, 0, WinWidth, WinHeight, *10 images/%image%
			if (imgX > 0) {
				Click %imgX%, %imgY%
				if (idx = 1) {
					break 2
				}
			}
		}
		Sleep 1000
	}
}

FindImageAndCheck(images*) {
	global WinWidth
	global WinHeight
	Loop {
		for idx, image in images {
			ImageSearch imgX, imgY, 0, 0, WinWidth, WinHeight, *10 images/%image%
			if (imgX > 0) {
				if (idx = 1) {
					break 2
				}
				else {
					Click %imgX%, %imgY%
				}
			}
		}
		Sleep 1000
	}
}

file_name := "config.txt"
file := FileOpen(file_name, "rw")
if !IsObject(file)
{
	MsgBox Can't open "%file_name%" for reading.
	return
}

eof := 0
while (eof = 0) {
	pos := file.Position
	line := file.ReadLine()
	line_arr := StrSplit(line, ["=",";"], " `t`r`n")
	
	if (line_arr[1] = "boss") {
		boss := line_arr[2]
		boss_img1 := boss . "1.png"
		boss_img2 := boss . "2.png"
	}
	
	if (line_arr[1] = "use_rw") {
		use_rw := line_arr[2]
	}
	
	if (line_arr[1] = "rw_name") {
		rw_name := line_arr[2]
		rw_img1 := rw_name . "1.png"
		rw_img2 := rw_name . "2.png"
		rw_img3 := rw_name . "3.png"
		rw_file1 := rw_name . "1.csv"
		rw_file2 := rw_name . "2.csv"
		rw_file3 := rw_name . "3.csv"
		rw_file4 := rw_name . "4.csv"
	}
	
	if (line_arr[1] = "rw_preloaded") {
		rw_preloaded := line_arr[2]
	}
	
	if (line_arr[1] = "restart_nox") {
		restart_nox := line_arr[2]
	}
	
	if (line_arr[1] = "restart_number") {
		restart_number := line_arr[2]
	}
	
	if (line_arr[1] = "characters") {
		characters := StrSplit(line_arr[2], ",", " `t`r`n")
	}
	
	if (SubStr(line_arr[1], 1, -1) = "char_abils") {
		char_num := SubStr(line_arr[1], 0)
		character := characters[char_num]
		abil_arr := StrSplit(line_arr[2], ",", " `t`r`n")
		abil_img1 := abil_arr[1] . "1.png"
		abil_img2 := abil_arr[2] . "2.png"
		char_abils[character] := [abil_img1, abil_img2]
	}
	
	if (SubStr(line_arr[1], 1, -1) = "char_orders") {
		char_num := SubStr(line_arr[1], 0)
		character := characters[char_num]
		order_arr := StrSplit(line_arr[2], ",", " `t`r`n")
		for idx, order in order_arr {
			order_arr[idx] := %order%
		}
		char_orders[character] := order_arr
	}
	
	if (line_arr[1] = "total_run_counter") {
		total_run_counter := line_arr[2]
		total_run_counter_pos := pos
	}
	
	if (line_arr[1] = "green_counter") {
		green_counter := line_arr[2]
		green_counter_pos := pos
	}
	
	eof := file.AtEOF
}

if (total_run_counter_pos = 0) {
	total_run_counter_pos := file.Position
	file.WriteLine("total_run_counter = 0")
}

if (green_counter_pos = 0) {
	green_counter_pos := file.Position
	file.WriteLine("green_counter = 0")
}

file.Close()

^!s:: ; Start from the main screen (dungeon difficulty select screen)
MainScreen:
if (run_counter > restart_number and restart_nox = 1) {
	Goto Restart
}

if (Mod(total_run_counter, 100) = 0 and use_rw = 1 and skip_friends = 0) {
	if (total_run_counter > 0 or rw_preloaded = 0) {
		Goto AcquireFriends
	}
}
skip_friends := 0

FindImageAndCheck("refresh.png", "next.png", "solo.png", "enter.png", boss_img2)

RoamingWarriorScreen:
Loop {
	ImageSearch, rw1X, rw1Y, 0, 0, WinWidth, WinHeight, *10 images/%rw_img1%
	ImageSearch, rw2X, rw2Y, 0, 0, WinWidth, WinHeight, *10 images/%rw_img2%
	ImageSearch, rw3X, rw3Y, 0, 0, WinWidth, WinHeight, *10 images/%rw_img3%
	
	ImageSearch, refreshX, refreshY, 0, 0, WinWidth, WinHeight, *10 images/refresh.png
	ImageSearch, goX, goY, 0, 0, WinWidth, WinHeight, *10 images/go.png
	
	ImageSearch, StaminaX, StaminaY, 0, 0, WinWidth, WinHeight, *10 images/stamina.png
	if (StaminaX > 0) {
		break
	}
	else if (rw1X > 0 and use_rw = 1) {
		if (goX > 0) {
			Click %goX%, %goY%
		}
	}
	else if (rw2X > 0 and use_rw = 1) {
		selX := sel2[1]
		selY := sel2[2]
		Click %selX%, %selY%
		Sleep 500
		if (goX > 0) {
			Click %goX%, %goY%
		}
	}
	else if (rw3X > 0 and use_rw = 1) {
		selX := sel3[1]
		selY := sel3[2]
		Click %selX%, %selY%
		Sleep 500
		if (goX > 0) {
			Click %goX%, %goY%
		}
	}
	else if (use_rw = 0) {
		if (goX > 0) {
			Click %goX%, %goY%
		}
	}
	else {
		if (refreshX > 0) {
			Click %refreshX%, %refreshY%
		}
	}
	Sleep 1000
}

BattleMap:
FindImageAndClick("begin.png", "stamina.png")

CancelAuto:
FindImageAndCheck("auto.png", "cancel.png")

^!m::
MoveCharacter:
for idx, char in characters {
	char_counter[char] := 0
}
last_char := ""
Loop {
	for idx, char in characters {
		ab1_img := char_abils[char][1]
		ab2_img := char_abils[char][2]
		BottomQuarter := 3 * WinHeight / 4
		ImageSearch, ab1X, ab1Y, 0, BottomQuarter, WinWidth, WinHeight, *10 images/%ab1_img%
		ImageSearch, ab2X, ab2Y, 0, BottomQuarter, WinWidth, WinHeight, *10 images/%ab2_img%
		if (ab1X > 0 and ab2X > 0) {
			max_idx := char_orders[char].MaxIndex()
			if (last_char <> char) ; prevents dropped input
			{
				char_counter[char] := Mod(char_counter[char], max_idx) + 1
			}
			moveX := char_orders[char][char_counter[char]][1]
			moveY := char_orders[char][char_counter[char]][2]
			
			Click %moveX%, %moveY%
			last_char := char
		}	
	}
	Sleep 200
	ImageSearch, nextX, nextY, 0, 0, WinWidth, WinHeight, *10 images/next2.png
	if (ErrorLevel = 0) {
		break
	}
	ImageSearch, quitX, quitY, 0, 0, WinWidth, WinHeight, *10 images/quit.png
	if (ErrorLevel = 0) {
		Goto FailureScreen
	}
}

ResultScreen:
Loop {
	Click %nextX%, %nextY%
	Sleep 1000
	ImageSearch followX, followY, 0, 0, WinWidth, WinHeight, *10 images/follow.png
	ImageSearch okX, okY, 0, 0, WinWidth, WinHeight, *10 images/ok.png
	ImageSearch ok2X, ok2Y, 0, 0, WinWidth, WinHeight, *10 images/ok2.png
	ImageSearch closeX, closeY, 0, 0, WinWidth, WinHeight, *10 images/close.png
	ImageSearch bossX, bossY, 0, 0, WinWidth, WinHeight, *10 images/%boss_img2%
	ImageSearch greenX, greenY, 0, 0, WinWidth, WinHeight, *10 images/green.png
	if (followX > 0) {
		Click %followX%, %followY%
	}
	if (okX > 0) {
		Click %okX%, %okY%
	}
	if (ok2X > 0) {
		Click %ok2X%, %ok2Y%
		run_counter := run_counter + 1
		total_run_counter := total_run_counter + 1
		file_name := "config.txt"
		file := FileOpen(file_name, "rw")
		file.Seek(total_run_counter_pos)
		line := "total_run_counter = " . total_run_counter
		file.WriteLine(line)
		file.Close()
		Goto StartScreen
	}
	if (closeX > 0) {
		Click %closeX%, %closeY%
	}
	if (greenX > 0) {
		green_counter := green_counter + 1
		file_name := "config.txt"
		file := FileOpen(file_name, "rw")
		file.Seek(green_counter_pos)
		line := "green_counter = " . green_counter
		file.WriteLine(line)
		file.Close()
	}
	if (bossX > 0) {
		run_counter := run_counter + 1
		total_run_counter := total_run_counter + 1
		file_name := "config.txt"
		file := FileOpen(file_name, "rw")
		file.Seek(total_run_counter_pos)
		line := "total_run_counter = " . total_run_counter
		file.WriteLine(line)
		file.Close()
		Goto MainScreen
	}
}

FailureScreen:
FindImageAndClick("quit.png")
FindImageAndClick("yes.png")

ResultScreen2:
FindImageAndCheck(boss_img2, "next3.png", "follow.png", "ok.png")
run_counter := run_counter + 1
total_run_counter := total_run_counter + 1
file_name := "config.txt"
file := FileOpen(file_name, "rw")
file.Seek(total_run_counter_pos)
line := "total_run_counter = " . total_run_counter
file.WriteLine(line)
file.Close()
Goto MainScreen

StartScreen:
FindImageAndClick("play.png")

HomeScreen:
FindImageAndClick("event.png", "ok3.png", "ok4.png", "close2.png")
FindImageAndClick("raid.png")
FindImageAndClick(boss_img1)
Sleep 3000
Goto MainScreen

Restart:
run_counter := 0
FindImageAndClick("kill.png")
FindImageAndClick("restart.png")
Sleep 30000

^!h:: ; resume from nox home screen
WinGetActiveStats, Title, WinWidth, WinHeight, WinX, WinY
Loop 100{
	ImageSearch installX, installY, 0, 0, WinWidth, WinHeight, *10 images/install.png
	ImageSearch ffrkX, ffrkY, 0, 0, WinWidth, WinHeight, *10 images/ffrk.png
	if (installX > 0) {
		installX := installX + 300 ; this moves outside of the popup so it doesn't trigger it
		Click %installX%, %installY%
	}
	if (ffrkX > 0) {
		Click %ffrkX%, %ffrkY%
		Sleep 5000
		WinGetActiveStats, Title, WinWidth, WinHeight, WinX, WinY
		Goto StartScreen
	}
	Sleep 1000
}
return

AcquireFriends:
FindImageAndClick("home.png")
FindImageAndCheck("following.png", "list.png", "friends.png", "menu.png")
Loop 100 {
	ImageSearch notX, notY, 0, 0, WinWidth, WinHeight, *50 images/not.png
	if (ErrorLevel = 0) {
		break
	}
	Loop 10{
		ImageSearch, followingX, followingY, 0, 0, WinWidth, WinHeight, *50 images/following.png
		if (ErrorLevel = 0) {
			Click 70, 400
			Sleep 300
			break
		}
		Sleep 100
	}
	Loop 10{
		ImageSearch, unfollow_closeX, unfollow_closeY, 0, 0, WinWidth, WinHeight, *50 images/unfollow_close.png
		if (ErrorLevel = 0) {
			Click 420, 770
			Sleep 300
			break
		}
		Sleep 100
	}
	Loop 10{
		ImageSearch, unfollow2X, unfollow2Y, 0, 0, WinWidth, WinHeight, *50 images/unfollow2.png
		if (ErrorLevel = 0) {
			Click %unfollow2X%, %unfollow2Y%
			Sleep 300
			break
		}
		Sleep 100
	}
	Loop 10{
		ImageSearch, unfollow_okX, unfollow_okY, 0, 0, WinWidth, WinHeight, *50 images/unfollow_ok.png
		if (ErrorLevel = 0) {
			Click %unfollow_okX%, %unfollow_okY%
			Sleep 300
			break
		}
		Sleep 100
	}
}
FindImageAndClick("back.png")
FindImageAndCheck("search2.png", "find.png")
if (Mod(total_run_counter, 400) = 0) {
	file_name := "roaming_warriors/" . rw_file1
}
if (Mod(total_run_counter, 400) = 100) {
	file_name := "roaming_warriors/" . rw_file2
}
if (Mod(total_run_counter, 400) = 200) {
	file_name := "roaming_warriors/" . rw_file3
}
if (Mod(total_run_counter, 400) = 300) {
	file_name := "roaming_warriors/" . rw_file4
}
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
		if (ErrorLevel = 0) {
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
	eof := file.AtEOF
}
file.Close()
FindImageAndClick("home2.png")
skip_friends := 1
Goto HomeScreen

^!p::pause ; pause script
^!r::Reload  ; reload script

^!t:: ; Test
ImageSearch, FoundX, FoundY, 0, 0, WinWidth, WinHeight, *10 images/thiefs_revenge2.png
if (ErrorLevel = 0) {
	MsgBox Found image at %FoundX%, %FoundY%
}
else {
	a := [500, 600]
	b := [700, 800]
	c := [a, b]
	d := 1
	e := 2
	x := c[d][d]
	y := c[e][e]
	MsgBox Could not find image %WinWidth%, %WinHeight%
}
return