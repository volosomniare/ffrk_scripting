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
use_dvg := 0 ; should game search for divine veil grimoire rw? 1-yes 0-no 
use_hmg := 0 ; should game search for hyper mighty guard rw? 1-yes 0-no

characters := ["locke", "tyro", "rydia", "papa", "terra"]

locke := ["ruby_spark1.png", "soul_burn2.png"]
tyro := ["ruby_spark1.png", "fire_assault2.png"]
rydia := ["valigarmanda1.png", "neo_bahamut2.png"]
papa := ["chain_firaja1.png", "chain_firaga2.png"]
terra := ["meltdown1.png", "sudden_freeze2.png"]

locke_moves := [sb, ab1, ab2, ab1, ab2, ab1]
tyro_moves := [sb, ab2, ab2, ab2, ab2, ab2]
rydia_moves := [ab1]
papa_moves := [rw, ab1, ab1, ab1, ab1, ab1]
terra_moves := [ab1]

; DO NOT EDIT BEYOND HERE
char_counter := {}


^!s:: ; Start from the main screen (dungeon difficulty select screen)
MainScreen:
for idx, char in characters {
	char_counter[char] := 0
}

ImageSearch, FoundX, FoundY, 0, 0, WinWidth, WinHeight, images/ochu.png
if (ErrorLevel = 1) {
	MsgBox Could not find "ochu" button on the main screen.
}
else {
	Click %FoundX%, %FoundY%
	Sleep 1000
}

SummaryScreen:
Loop {
	ImageSearch, FoundX, FoundY, 0, 0, WinWidth, WinHeight, images/enter.png
	if (ErrorLevel = 0) {
		Click %FoundX%, %FoundY%
		Sleep 1000
		break
	}
}

RaidTypeSelect:
ImageSearch, FoundX, FoundY, 0, 0, WinWidth, WinHeight, images/solo.png
if (ErrorLevel = 1) {
	MsgBox Could not find "solo" button on the raid type screen.
}
else {
	Click %FoundX%, %FoundY%
	Sleep 2000
}

PartyScreen:
Loop {
	ImageSearch, FoundX, FoundY, 0, 0, WinWidth, WinHeight, images/next.png
	if (ErrorLevel = 0) {
		Sleep 500
		Click %FoundX%, %FoundY%
		Sleep 2000
		break
	}
	Sleep 1000
}

RoamingWarriorScreen:
Loop {
	ImageSearch, refreshX, refreshY, 0, 0, WinWidth, WinHeight, images/refresh.png
	if (refreshX > 0) {
		break
	}
	Sleep 1000
}
Loop {
	ImageSearch, dvg1X, dvg1Y, 0, 0, WinWidth, WinHeight, images/dvg1.png
	ImageSearch, dvg2X, dvg2Y, 0, 0, WinWidth, WinHeight, images/dvg2.png
	ImageSearch, dvg3X, dvg3Y, 0, 0, WinWidth, WinHeight, images/dvg3.png
	ImageSearch, hmg1X, hmg1Y, 0, 0, WinWidth, WinHeight, images/hmg1.png
	ImageSearch, hmg2X, hmg2Y, 0, 0, WinWidth, WinHeight, images/hmg2.png
	ImageSearch, hmg3X, hmg3Y, 0, 0, WinWidth, WinHeight, images/hmg3.png
	ImageSearch, goX, goY, 0, 0, WinWidth, WinHeight, images/go.png
	if ((dvg1X > 0 and use_dvg = 1) or (hmg1X > 0 and use_hmg = 1)) {
		Click %goX%, %goY%
		break
	}
	else if ((dvg2X > 0 and use_dvg = 1) or (hmg2X > 0 and use_hmg = 1)) {
		selX := sel2[1]
		selY := sel2[2]
		Click %selX%, %selY%
		Sleep 500
		Click %goX%, %goY%
		break
	}
	else if ((dvg3X > 0 and use_dvg = 1) or (hmg3X > 0 and use_hmg = 1)) {
		selX := sel3[1]
		selY := sel3[2]
		Click %selX%, %selY%
		Sleep 500
		Click %goX%, %goY%
		break
	}
	else if (use_dvg = 0 and use_hmg = 0) {
		Click %goX%, %goY%
		break
	}
	Click %refreshX%, %refreshY%
	Sleep 2000
}
Sleep 2000

^!b:: ; Start from battle map
BattleMap:
Loop {
	ImageSearch, FoundX, FoundY, 0, 0, WinWidth, WinHeight, images/stamina.png
	if (ErrorLevel = 0) {
		Click %FoundX%, %FoundY%
		Sleep 1000
		break
	}
	Sleep 500
}

ImageSearch, FoundX, FoundY, 0, 0, WinWidth, WinHeight, images/begin.png
if (ErrorLevel = 1) {
	MsgBox Could not find "begin battle" button on the battle map.
}
else {
	Click %FoundX%, %FoundY%
	Sleep 5000
}

CancelAuto:
Loop {
	ImageSearch, CancelX, CancelY, 0, 0, WinWidth, WinHeight, images/cancel.png
	ImageSearch, AutoX, AutoY, 0, 0, WinWidth, WinHeight, images/auto.png
	if (CancelX > 0) {
		Click %CancelX%, %CancelY%
		break
	}
	if (AutoX > 0) {
		break
	}
	Sleep 500
}

MoveCharacter:
Loop {
	for idx, char in characters {
		ab_imgs := %char%
		ab1_img := ab_imgs[1]
		ab2_img := ab_imgs[2]
		BottomQuarter := 3 * WinHeight / 4
		ImageSearch, ab1X, ab1Y, 0, BottomQuarter, WinWidth, WinHeight, images/%ab1_img%
		ImageSearch, ab2X, ab2Y, 0, BottomQuarter, WinWidth, WinHeight, images/%ab2_img%
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
	ImageSearch, nextX, nextY, 0, 0, WinWidth, WinHeight, images/next2.png
	if (ErrorLevel = 0) {
		break
	}
	ImageSearch, quitX, quitY, 0, 0, WinWidth, WinHeight, images/quit.png
	if (ErrorLevel = 0) {
		Goto FailureScreen
	}
}

ResultScreen:
Loop {
	Click %nextX%, %nextY%
	Sleep 1000
	ImageSearch, nextX, nextY, 0, 0, WinWidth, WinHeight, images/ochu.png
	if (ErrorLevel = 0) {
		Goto MainScreen
	}
}

FailureScreen:
Click %quitX%, %quitY%
Sleep 1000
ImageSearch yesX, yesY, 0, 0, WinWidth, WinHeight, images/yes.png
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
	ImageSearch nextX, nextY, 0, 0, WinWidth, WinHeight, images/next3.png
	Click %nextX%, %nextY%
	Sleep 1000
	ImageSearch, nextX, nextY, 0, 0, WinWidth, WinHeight, images/ochu.png
	if (ErrorLevel = 0) {
		Goto MainScreen
	}
}

^!p::pause ; pause script
^!r::Reload  ; reload script

^!t:: ; Test
ImageSearch, FoundX, FoundY, 0, 0, WinWidth, WinHeight, images/stamina.png
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