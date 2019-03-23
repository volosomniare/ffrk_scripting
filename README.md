# ffrk_scripting

The purpose of these scripts is to autoplay certain battles in Final Fantasy Record Keeper on an emulator.

## Prerequistes
* MuMu App Player (http://mumu.163.com/global/download/en/)
* FFRK installed and working on MuMu
* AutoHotkey (https://www.autohotkey.com)
* A strong and consistent team that can beat the battle you intend to repeat (this script can't substitute for bad teambuilding)

## Instructions
1. Open `config_example.txt` with a text editor of your choice (such as notepad).
Each of these lines can be customized for your specific needs. Below are some of the more important ones.

* `boss` refers to which raid boss you wish to tackle. The name is completely lowercased and if made up of two or more words, the words are separated by an underscore such as `red_dragon`
* `use_rw` refers to whether you wish to make use of a specific roaming warrior soul break during your battle. `1` means yes, `0` means no.
* `rw_name` refers to the name of the roaming warrior soul break you wish to use (ignore if you set the previous setting to `0`). Currently supporting Onion Knight pUSB (`pusb`), Tyro's Divine Veil Grimoire (`dvg`), Terra's ASB (`terra_asb`), and Sora's AASB (`sora_aasb`). Contact me by writing an issue here if you want support for more.
* `characters` refers to the names of the characters of your team, separated by commas. (remove special characters from names e.g. `y'shtola` should be `yshtola`)

* `char_orders` are the commands you want the characters to make in the game.
  For example, if your yda is equipped with mako might and you want her to immediately use her soul break followed by 3 casts of her second ability and repeat, then this is what it looks like: ```char_orders = sb, ab2, ab2, ab2```
  possible orders include `att`, `def`, `ab1`, `ab2`, `sb`, `rw`, and `mag` (though no magicite is currently allowed in raid battles)

2. When you're done editing `config_example.txt`, save it as `config.txt` in the same folder.
3. Double click `ffrk_raid.ahk` and there should be a green H icon on the right side of your taskbar
4. Open ffrk in MuMu and go to the raid screen that displays the difficulty
5. Press Ctr-Alt-C and the script will start running

## Appendix/Updates
* `ffrk_realm.ahk` was added for repeating certain realm dungeons.
* To use that script, you must edit `config_realm_example.txt` instead and save it as `config_realm.txt` (there are additional options with comments detailing what they do in the example file).
* Currently the only realm dungeon repeatable is fabul castle. 
* In order for the script to work, you must first clear fabul castle once, since the game will display the last dungeon completed at the top of the dungeon select. Then press Ctr-Alt-C at the dungeon select and the script should work.
