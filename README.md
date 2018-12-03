# ffrk_scripting

The purpose of this script is to autoplay the ochu multiplayer raid battle of Final Fantasy Record Keeper.

The following is the instructions to use it

1. Install Nox Android Emulator (https://www.bignox.com) and install ffrk on it.
2. Install AutoHotkey (https://www.autohotkey.com)
3. Customize the script to the team you wish to run:
Open `ochu.ahk` with a text editor of your choice (such as notepad).
You should see a section of code like this
```
characters := ["locke", "ignis", "auron", "papa", "terra"]

locke := ["ruby_spark1.png", "soul_burn2.png"]
ignis := ["ruby_spark1.png", "fire_assault2.png"]
auron := ["smoldering_moon1.png", "warring_flame2.png"]
papa := ["chain_firaja1.png", "chain_firaga2.png"]
terra := ["meltdown1.png", "sudden_freeze2.png"]

locke_moves := [sb, ab1, ab2, ab1, ab2, ab1]
ignis_moves := [sb, ab2, ab2, ab2, ab2, ab2]
auron_moves := [ab1, ab2, ab2, ab2]
papa_moves := [rw, ab1, ab1, ab1, ab1, ab1]
terra_moves := [ab1]
```
The first part are the names of the characters of your team.
You should put in their name enclosed by quotes, preferably without any special characters (so `"yda"` instead of `"y'da"`)

The second part are the abilities equipped on these characters.
So if your yda has the moves fires within and ironfist fire in slots 1 and 2 respectively, then you would put

```yda := ["fires_within1.png", "ironfist_fire2.png"]```

Make sure that these images are present in the images folder, if they're not there, you must make them and put them in the folder.

The third part are the commands you want the characters to make in the game.
For example, if your yda is equipped with mako might and you want her to immediately use her soul break followed by 3 ironfist fire and repeat, then this is what it looks like:

```yda_moves := [sb, ab2, ab2, ab2]```

Save the script once you're done with the changes

4. Double click `ochu.ahk` and there should be a green H icon on the right side of your taskbar
5. Open ffrk in Nox and go to the ochu raid screen that displays the difficulty
6. Press Ctr-Alt-C and the script will start running
