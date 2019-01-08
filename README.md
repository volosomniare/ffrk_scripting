# ffrk_scripting

The purpose of this script is to autoplay multiplayer raid battle of Final Fantasy Record Keeper.

The following is the instructions to use it

1. Install Nox Android Emulator (https://www.bignox.com) and install ffrk on it.
2. Install AutoHotkey (https://www.autohotkey.com)
3. Open `config_example.txt` with a text editor of your choice (such as notepad).
Each of these lines can be customized for your specific needs.

* `boss` refers to which raid boss you wish to tackle. The name is completely lowercased and if made up of two or more words, the words are separated by an underscore such as `red_dragon`
* `use_rw` refers to whether you wish to make use of a specific roaming warrior soul break during your battle. `1` means yes, `0` means no.
* `rw_name` refers to the name of the roaming warrior soul break you wish to use (ignore if you set the previous setting to `0`). Currently supporting Onion Knight pUSB (`pusb`), Tyro's Divine Veil Grimoire (`dvg`), and Terra's ASB (`terra_asb`), contact me by writing an issue here if you want support for more.
* `rw_preloaded` refers to whether you've already preloaded your friends list with the roaming warrior you chose. If not the game will at the start remove all your friends and fill your friends list to be all of the roaming warrior you chose.
* `characters` refers to the names of the characters of your team, separated by commas. (remove special characters from names like `y'da` should be `yda`)
* `char_abils` are the abilities equipped on these characters:
  So if your first character has the moves fires within and ironfist fire in slots 1 and 2 respectively, then you would put: ```char_abils1 = fires_within, ironfist_fire```  
  Note: many abilities don't currently have images in the images folder, you can either make your own or create an issue and I'll create them for you.  

* `char_orders` are the commands you want the characters to make in the game.
  For example, if your yda is equipped with mako might and you want her to immediately use her soul break followed by 3 ironfist fire and repeat, then this is what it looks like: ```char_orders = sb, ab2, ab2, ab2```
  possible orders include `att`, `def`, `ab1`, `ab2`, `sb`, `rw`, and `mag` (though no magicite is currently allowed in raid battles)

4. When you're done editing `config_example.txt`, save it as `config.txt` in the same folder.
5. Double click `ffrk_raid.ahk` and there should be a green H icon on the right side of your taskbar
6. Open ffrk in Nox and go to the raid screen that displays the difficulty
7. Press Ctr-Alt-C and the script will start running
