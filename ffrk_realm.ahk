; constant initialization and function definitions 
^!c:: ; initialize constants
WinGetActiveStats, Title, WinWidth, WinHeight, WinX, WinY

char_counter := {}
run_counter := 0
total_run_counter := 0
total_run_counter_pos := 0
green_counter := 0
green_counter_pos := 0
battle_num := 1

char_orders := {}
img_dir := "images"

FindImageAndClick(images*) {
	global WinWidth
	global WinHeight
	global img_dir
	restart_counter := 0
	Loop {
		if (restart_counter >= 300) {
			gosub Restart
			break
		}
		
		for idx, image in images {
			ImageSearch imgX, imgY, 0, 0, WinWidth, WinHeight, *25 %img_dir%/%image%
			if (imgX > 0) {
				Click %imgX%, %imgY%
				if (idx = 1) {
					break 2
				}
			}
		}
		restart_counter := restart_counter + 1
		Sleep 1000
	}
}

FindImageAndCheck(images*) {
	global WinWidth
	global WinHeight
	global img_dir
	restart_counter := 0
	Loop {
		if (restart_counter >= 300) {
			gosub Restart
			break
		}
		for idx, image in images {
			ImageSearch imgX, imgY, 0, 0, WinWidth, WinHeight, *25 %img_dir%/%image%
			if (imgX > 0) {
				if (idx = 1) {
					break 2
				}
				else {
					Click %imgX%, %imgY%
				}
			}
		}
		restart_counter := restart_counter + 1
		Sleep 1000
	}
}

file_name := "config_realm.txt"
file := FileOpen(file_name, "rw `n")
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
	
	if (line_arr[1] = "emulator") {
		emulator := line_arr[2]
		if (emulator = "mumu") {
			img_dir := "images/mumu"
		}
		if (emulator = "nox") {
			img_dir := "images/nox"
		}
		if (emulator = "memu") {
			img_dir := "images/memu"
		}
	}
	
	if (line_arr[1] = "realm") {
		realm := line_arr[2]
		realm_img := realm . ".png"
	}

    if (line_arr[1] = "dungeon") {
		dungeon := line_arr[2]
		dungeon_img := dungeon . ".png"
        dungeon_img0 := dungeon . "0.png"
        dungeon_img1 := dungeon . "1.png"
        dungeon_img2 := dungeon . "2.png"
        dungeon_img3 := dungeon . "3.png"
	}

    if (line_arr[1] = "auto_battle") {
        auto_battle := line_arr[2]
    }

    if (line_arr[1] = "complete_dungeon") {
        complete_dungeon := line_arr[2]
    }
	
	if (line_arr[1] = "use_rw") {
		use_rw := line_arr[2]
	}
	
	if (line_arr[1] = "rw_name") {
		rw_name := line_arr[2]
		rw_img1 := rw_name . "1.png"
		rw_img2 := rw_name . "2.png"
		rw_img3 := rw_name . "3.png"
	}
	
	if (line_arr[1] = "restart_emulator") {
		restart_emulator := line_arr[2]
	}
	
	if (line_arr[1] = "restart_number") {
		restart_number := line_arr[2]
	}
	
	if (line_arr[1] = "characters") {
		characters := StrSplit(line_arr[2], ",", " `t`r`n")
	}
	
	if (SubStr(line_arr[1], 1, -1) = "char_orders") {
		char_num := SubStr(line_arr[1], 0)
		character := characters[char_num]
		order_arr := StrSplit(line_arr[2], ",", " `t`r`n")
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

;roaming warrior select coordinates
sel2 := (emulator = "memu") ? [480, 610] : [480, 630]
sel3 := (emulator = "memu") ? [480, 750] : [480, 770]

;battle command coordinates
att := (emulator = "memu") ? [50, 810] : [50, 840]
def := (emulator = "memu") ? [150, 810] : [150, 840]
ab1 := (emulator = "memu") ? [250, 810] : [250, 840]
ab2 := (emulator = "memu") ? [350, 810] : [350, 840]
sb := (emulator = "memu") ? [450, 810] : [480, 840]
rw := (emulator = "memu") ? [180, 680] : [180, 700]
mag := (emulator = "memu") ? [300, 680] : [300, 700]

;friend list coordinates
frnd := (emulator = "memu") ? [70, 400] : [70, 400]
fol := (emulator = "memu") ? [400, 750] : [420, 770]
frnd_id := (emulator = "memu") ? [150, 420] : [150, 450]

^!s:: ; Start from the main screen (dungeon difficulty select screen)
MainScreen:
if (run_counter > restart_number and restart_emulator = 1) {
	Goto Restart
}

Loop {
    ImageSearch, dungeonX, dungeonY, 0, 0, WinWidth, WinHeight, *25 %img_dir%/%dungeon_img%
    if (dungeonX > 0) {
        Click %dungeonX%, %dungeonY%
        break
    }
    MouseMove 300, 700
    MouseClickDrag, Left, 0, 0, 0, -500, 20 , R
    Sleep 1000
}
battle_num := 1
battle_img_name := "dungeon_img" . battle_num
battle_img := %battle_img_name%

FindImageAndCheck("roaming_warrior.png", "next.png", "next4.png", "solo.png", "enter.png", "close.png")

RoamingWarriorScreen:
Loop {
	ImageSearch, rw1X, rw1Y, 0, 0, WinWidth, WinHeight, *25 %img_dir%/%rw_img1%
	ImageSearch, rw2X, rw2Y, 0, 0, WinWidth, WinHeight, *25 %img_dir%/%rw_img2%
	ImageSearch, rw3X, rw3Y, 0, 0, WinWidth, WinHeight, *25 %img_dir%/%rw_img3%
	
	ImageSearch, goX, goY, 0, 0, WinWidth, WinHeight, *25 %img_dir%/go.png
	
	ImageSearch, BattleX, BattleY, 0, 0, WinWidth, WinHeight, *25 %img_dir%/%battle_img%
	if (BattleX > 0) {
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
	Sleep 1000
}

^!b::
BattleMap:
if (auto_battle > 0) {
    FindImageAndCheck("cancel.png", "auto.png", "begin2.png", "begin.png", battle_img, "potion.png", "yes2.png", "ok7.png")
}
else {
    FindImageAndCheck("auto.png", "cancel.png", "begin2.png", "begin.png", battle_img, "potion.png", "yes2.png", "ok7.png")
}

^!m::
MoveCharacter:
for idx, char in characters {
	char_counter[char] := 0
}
last_char := ""
last_char_counter := 0
Loop {
	for idx, char in characters {
		char_img := "characters/" . char . ".png"
		ImageSearch, charX, charY, 0, 0, WinWidth, WinHeight, *25 %img_dir%/%char_img%
		if (charX > 0) {
			max_idx := char_orders[char].MaxIndex()
			if (last_char <> char) ; prevents dropped input
			{
				last_char_counter := 0
				char_counter[char] := Mod(char_counter[char], max_idx) + 1
			}
			else {
				last_char_counter := last_char_counter + 1
				if (last_char_counter > 5) {
					last_char_counter := 0
					char_counter[char] := Mod(char_counter[char], max_idx) + 1
				}
			}
			move_name := char_orders[char][char_counter[char]]
			move := %move_name%
			moveX := move[1]
			moveY := move[2]
			
			Click %moveX%, %moveY%
			last_char := char
		}	
	}
	Sleep 200
	ImageSearch, nextX, nextY, 0, 0, WinWidth, WinHeight, *25 %img_dir%/next2.png
	if (ErrorLevel = 0) {
		break
	}
	ImageSearch, quitX, quitY, 0, 0, WinWidth, WinHeight, *25 %img_dir%/quit.png
	if (ErrorLevel = 0) {
		Goto FailureScreen
	}
}

ResultScreen:
result_counter := 0
Loop {
	if (result_counter > 100) {
		Goto Restart
	}
	Click %nextX%, %nextY%
	Sleep 1000
	ImageSearch followX, followY, 0, 0, WinWidth, WinHeight, *25 %img_dir%/follow.png
	ImageSearch okX, okY, 0, 0, WinWidth, WinHeight, *25 %img_dir%/ok.png
	ImageSearch ok2X, ok2Y, 0, 0, WinWidth, WinHeight, *25 %img_dir%/ok2.png
	ImageSearch ok5X, ok5Y, 0, 0, WinWidth, WinHeight, *25 %img_dir%/ok5.png
	ImageSearch closeX, closeY, 0, 0, WinWidth, WinHeight, *25 %img_dir%/close.png
    ImageSearch campX, campY, 0, 0, WinWidth, WinHeight, *25 %img_dir%/camp.png
	ImageSearch eliteX, eliteY, 0, 0, WinWidth, WinHeight, *25 %img_dir%/elite.png
	if (followX > 0) {
		Click %followX%, %followY%
	}
	if (okX > 0) {
		Click %okX%, %okY%
	}
	if (okX > 0) {
		Click %ok5X%, %ok5Y%
	}
	if (ok2X > 0) {
		Click %ok2X%, %ok2Y%
		run_counter := run_counter + 1
		total_run_counter := total_run_counter + 1
		file_name := "config.txt"
		file := FileOpen(file_name, "rw `n")
		file.Seek(total_run_counter_pos)
		line := "total_run_counter = " . total_run_counter
		file.WriteLine(line)
		file.Close()
		Goto StartScreen
	}
	if (closeX > 0) {
		Click %closeX%, %closeY%
	}
    if (campX > 0) {
        if (complete_dungeon > 0) {
            battle_num := battle_num + 1
        }
        else {
            battle_num := 0
        }
        battle_img_name := "dungeon_img" . battle_num
        battle_img := %battle_img_name%
        Goto BattleMap
    }
	if (eliteX > 0) {
		run_counter := run_counter + 1
		total_run_counter := total_run_counter + 1
		file_name := "config.txt"
		file := FileOpen(file_name, "rw `n")
		file.Seek(total_run_counter_pos)
		line := "total_run_counter = " . total_run_counter
		file.WriteLine(line)
		file.Close()
		Goto MainScreen
	}
	result_counter := result_counter + 1
}

FailureScreen:
FindImageAndClick("quit.png")
FindImageAndClick("yes.png")

ResultScreen2:
FindImageAndCheck(boss_img2, "next3.png", "follow.png", "ok.png")
run_counter := run_counter + 1
total_run_counter := total_run_counter + 1
file_name := "config.txt"
file := FileOpen(file_name, "rw `n")
file.Seek(total_run_counter_pos)
line := "total_run_counter = " . total_run_counter
file.WriteLine(line)
file.Close()
Goto MainScreen

StartScreen:
FindImageAndClick("play.png")
Sleep 5000

ImageSearch cancelX, cancelY, 0, 0, WinWidth, WinHeight, *25 %img_dir%/cancel2.png
if (cancelX > 0) {
	Click %cancelX%, %cancelY%
	Goto BattleMap
}

HomeScreen:
FindImageAndClick("realm.png", "ok3.png", "ok4.png", "close2.png", "back2.png")
FindImageAndClick(realm_img)
FindImageAndClick("realm_door.png")
Sleep 3000
Goto MainScreen

Restart:
run_counter := 0
ImageSearch killX, killY, 0, 0, WinWidth, WinHeight, *25 %img_dir%/kill.png
if (killX > 0) {
	Click %killX%, %killY%
}
Sleep 1000
ImageSearch restartX, restartY, 0, 0, WinWidth, WinHeight, *25 %img_dir%/restart.png
if (restartX > 0) {
	Click %restartX%, %restartY%
}
Sleep 10000

^!h:: ; resume from emulator home screen
WinGetActiveStats, Title, WinWidth, WinHeight, WinX, WinY
Loop 100{
	ImageSearch installX, installY, 0, 0, WinWidth, WinHeight, *25 %img_dir%/install.png
	ImageSearch ffrkX, ffrkY, 0, 0, WinWidth, WinHeight, *25 %img_dir%/ffrk.png
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

^!p::pause ; pause script
^!r::Reload  ; reload script

^!t:: ; Test
WinGetActiveStats, Title, WinWidth, WinHeight, WinX, WinY
MouseMove 300, 700
MouseClickDrag, Left, 0, 0, 0, -500, 20 , R
; img_dir := "images/mumu"
; img := "close3.png"
; ImageSearch, FoundX, FoundY, 0, 0, WinWidth, WinHeight, *25 %img_dir%/%img%
; if (ErrorLevel = 0) {
; 	MsgBox Found image "%img%" at %FoundX%, %FoundY%
; }
; else {
; 	a := [500, 600]
; 	b := [700, 800]
; 	c := [&a, &b]
; 	for idx, val in c {
; 		test := *val
; 		test := test[1]
; 	}
; 	d := c[1]
; 	MsgBox Image "%img%" not found. Window size is %WinWidth% x %WinHeight%
; }