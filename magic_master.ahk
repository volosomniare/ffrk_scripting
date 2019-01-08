; constant initialization DO NOT EDIT
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


; YOU CAN EDIT THIS PART
use_rw := 1 ; should the game search for rw? 1-yes 0-no
rw_img1 := "terra_asb1.png" ; image of rw in slot 1
rw_img2 := "terra_asb2.png" ; image of rw in slot 2
rw_img3 := "terra_asb3.png" ; image of rw in slot 3

restart_nox := 1 ; should the game restart nox after doing a certain number of runs? 1-yes 0-no
restart_number := 60 ; how many runs should the game do before restarting nox

characters := ["terra", "yda", "locke", "auron", "tyro"]

terra := ["wrath1.png", "valigarmanda2.png"]
yda := ["wrath1.png", "lifebane2.png"]
locke := ["steal_power1.png", "steal_defense2.png"]
auron := ["wrath1.png", "iai_hellfire2.png"]
tyro := ["enfeebling_jitterbug1.png", "heathen_frolic_sarabande2.png"]

terra_moves := [ab1, ab1, ab1, sb]
yda_moves := [ab1, ab1, ab1, sb]
locke_moves := [ab1, ab2, sb, rw]
auron_moves := [ab1, ab1, ab1, sb]
tyro_moves := [sb, ab1, ab2, ab1, a2]

; DO NOT EDIT BEYOND HERE
char_counter := {}
run_counter := 0
total_run_counter := 0
green_counter := 0

^!s:: ; Start from the main screen (dungeon difficulty select screen)
MainScreen:
for idx, char in characters {
	char_counter[char] := 0
}
last_char := ""
run_counter := run_counter + 1
total_run_counter := total_run_counter + 1

if (run_counter > restart_number and restart_nox = 1) {
	Goto Restart
}

ImageSearch, magic_masterX, magic_masterY, 0, 0, WinWidth, WinHeight, *10 images/magic_master2.png
if (ErrorLevel = 1) {
	MsgBox Could not find "magic_master" button on the main screen.
}
else {
	Loop {
		if (magic_masterX > 0) {
			Click %magic_masterX%, %magic_masterY%
		}
		Sleep 1000
		ImageSearch, magic_masterX, magic_masterY, 0, 0, WinWidth, WinHeight, *10 images/magic_master2.png
		ImageSearch, EnterX, EnterY, 0, 0, WinWidth, WinHeight, *10 images/enter.png
		if (EnterX > 0) {
			break
		}
	}
}

SummaryScreen:
Loop {
	if (EnterX > 0) {
		Click %EnterX%, %EnterY%
	}
	Sleep 1000
	ImageSearch, EnterX, EnterY, 0, 0, WinWidth, WinHeight, *10 images/enter.png
	ImageSearch, SoloX, SoloY, 0, 0, WinWidth, WinHeight, *10 images/solo.png
	if (SoloX > 0) {
		break
	}
}

RaidTypeSelect:
Loop {
	if (SoloX > 0) {
		Click %SoloX%, %SoloY%
	}
	Sleep 1000
	ImageSearch, SoloX, SoloY, 0, 0, WinWidth, WinHeight, *10 images/solo.png
	ImageSearch, NextX, NextY, 0, 0, WinWidth, WinHeight, *10 images/next.png
	if (NextX > 0) {
		break
	}
}

PartyScreen:
Loop {
	if (NextX > 0) {
		Click %NextX%, %NextY%
	}
	Sleep 1000
	ImageSearch, NextX, NextY, 0, 0, WinWidth, WinHeight, *10 images/next.png
	ImageSearch, refreshX, refreshY, 0, 0, WinWidth, WinHeight, *10 images/refresh.png
	ImageSearch, goX, goY, 0, 0, WinWidth, WinHeight, *10 images/go.png
	ImageSearch, StaminaX, StaminaY, 0, 0, WinWidth, WinHeight, *10 images/stamina.png
	if ((refreshX > 0 and goX > 0) or StaminaX > 0) {
		break
	}
}

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
Loop {
	if (StaminaX > 0) {
		Click %StaminaX%, %StaminaY%
	}
	Sleep 1000
	ImageSearch, StaminaX, StaminaY, 0, 0, WinWidth, WinHeight, *10 images/stamina.png
	ImageSearch, BeginX, BeginY, 0, 0, WinWidth, WinHeight, *10 images/begin.png
	if (BeginX > 0) {
		break
	}
}

Loop {
	Click %BeginX%, %BeginY%
	Sleep 1000
	ImageSearch, BeginX, BeginY, 0, 0, WinWidth, WinHeight, *10 images/begin.png
	if (ErrorLevel <> 0) {
		break
	}
}

CancelAuto:
Loop {
	ImageSearch, CancelX, CancelY, 0, 0, WinWidth, WinHeight, *10 images/cancel.png
	ImageSearch, AutoX, AutoY, 0, 0, WinWidth, WinHeight, *10 images/auto.png
	if (CancelX > 0) {
		Click %CancelX%, %CancelY%
	}
	if (AutoX > 0) {
		break
	}
	Sleep 1000
}

MoveCharacter:
Loop {
	for idx, char in characters {
		ab_imgs := %char%
		ab1_img := ab_imgs[1]
		ab2_img := ab_imgs[2]
		BottomQuarter := 3 * WinHeight / 4
		ImageSearch, ab1X, ab1Y, 0, BottomQuarter, WinWidth, WinHeight, *10 images/%ab1_img%
		ImageSearch, ab2X, ab2Y, 0, BottomQuarter, WinWidth, WinHeight, *10 images/%ab2_img%
		if (ab1X > 0 and ab2X > 0) {
			char_moves := char . "_moves"
			char_moves := %char_moves%
			max_idx := char_moves.MaxIndex()
			if (last_char <> char) ; prevents dropped input
			{
				char_counter[char] := Mod(char_counter[char], max_idx) + 1
			}
			moveX := char_moves[char_counter[char]][1]
			moveY := char_moves[char_counter[char]][2]
			
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
	ImageSearch magic_masterX, magic_masterY, 0, 0, WinWidth, WinHeight, *10 images/magic_master2.png
	ImageSearch greenX, greenY, 0, 0, WinWidth, WinHeight, *10 images/green.png
	if (followX > 0) {
		Click %followX%, %followY%
	}
	if (okX > 0) {
		Click %okX%, %okY%
	}
	if (ok2X > 0) {
		Click %ok2X%, %ok2Y%
		Goto StartScreen
	}
	if (closeX > 0) {
		Click %closeX%, %closeY%
	}
	if (greenX > 0) {
		green_counter := green_counter + 1
	}
	if (magic_masterX > 0) {
		Goto MainScreen
	}
}

FailureScreen:
Click %quitX%, %quitY%
Sleep 1000
ImageSearch yesX, yesY, 0, 0, WinWidth, WinHeight, *10 images/yes.png
if (ErrorLevel = 0) {
	Click %yesX%, %yesY%
	Sleep 2000
	Goto ResultScreen2
}
else {
	MsgBox Could not find "yes" button on the quit screen.
}

ResultScreen2:
Loop {
	ImageSearch nextX, nextY, 0, 0, WinWidth, WinHeight, *10 images/next3.png
	Click %nextX%, %nextY%
	Sleep 1000
	ImageSearch followX, followY, 0, 0, WinWidth, WinHeight, *10 images/follow.png
	ImageSearch okX, okY, 0, 0, WinWidth, WinHeight, *10 images/ok.png
	ImageSearch magic_masterX, magic_masterY, 0, 0, WinWidth, WinHeight, *10 images/magic_master2.png
	if (followX > 0) {
		Click %followX%, %followY%
	}
	if (okX > 0) {
		Click %okX%, %okY%
	}
	if (magic_masterX > 0) {
		Goto MainScreen
	}
}

StartScreen:
Loop {
	ImageSearch playX, playY, 0, 0, WinWidth, WinHeight, *10 images/play.png
	if (playX > 0) {
		Click %playX%, %playY%
		break
	}
	Sleep 1000
}
Loop {
	ImageSearch ok3X, ok3Y, 0, 0, WinWidth, WinHeight, *10 images/ok3.png
	ImageSearch ok4X, ok4Y, 0, 0, WinWidth, WinHeight, *10 images/ok4.png
	ImageSearch close2X, close2Y, 0, 0, WinWidth, WinHeight, *10 images/close2.png
	ImageSearch eventX, eventY, 0, 0, WinWidth, WinHeight, *10 images/event.png
	if (ok3X > 0) {
		Click %ok3X%, %ok3Y%
	}
	if (ok4X > 0) {
		Click %ok4X%, %ok4Y%
	}
	if (close2X > 0) {
		Click %close2X%, %close2Y%
	}
	if (eventX > 0) {
		Click %eventX%, %eventY%
		break
	}
	Sleep 1000
}
Loop {
	ImageSearch raidX, raidY, 0, 0, WinWidth, WinHeight, *10 images/raid.png
	if (raidX > 0) {
		Click %raidX%, %raidY%
		break
	}
	Sleep 1000
}
Loop {
	ImageSearch magic_masterX, magic_masterY, 0, 0, WinWidth, WinHeight, *10 images/magic_master1.png
	if (magic_masterX > 0) {
		Click %magic_masterX%, %magic_masterY%
		Sleep 3000
		Goto MainScreen
	}
	Sleep 1000
}

Restart:
run_counter := 0
total_run_counter := total_run_counter - 1
ImageSearch killX, killY, 0, 0, WinWidth, WinHeight, *10 images/kill.png
if (killX > 0) {
	Click %killX%, %killY%
}
Sleep 1000

ImageSearch restartX, restartY, 0, 0, WinWidth, WinHeight, *10 images/restart.png
if (restartX > 0) {
	Click %restartX%, %restartY%
}
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