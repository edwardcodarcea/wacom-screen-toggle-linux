# wacom-screen-toggle-linux
### Script for toggling between multiple active screens for Wacom tablets in linux systems.

## How to use it from command line
- clone the project to `~/.wacom` (preferably)
    - if you clone it to other directory you should also change `CONFIG_FILE=~/.wacom/.config;` line to whatever directory you want.
        - this is a config file that saves your current screen mapping
- run `chmod +x switch.sh`
- run `./switch.sh`

The script will hopefully switch your Wacom tablet mapping from one screen to the other. 
It should work with multiple screens as well.

## How to map it to a Wacom tablet button
- run `xinput list | grep -i wacom`
    - you should get somethingS like:
    ```
    ⎜   ↳ Wacom Intuos BT S Pad pad               	id=26	[slave  pointer  (2)]
    ⎜   ↳ Wacom Intuos BT S Pen stylus            	id=27	[slave  pointer  (2)]
    ```
- run `xsetwacom set "Wacom Intuos BT S Pad pad" Button 2 "key ctrl+shift+pgdn"`
    - replace `Wacom Intuos BT S Pad pad` with whatever name of your pad is
    - also, you can replace `ctrl+shift+pgdn` with what combination of keys you want
    - you can also replace `Button 2` with whatever button you want on your tablet
- run `xbindkeys -d > ~/.xbindkeysrc` to generate xbindkeys config file
- open `~/.xbindkeysrc` and add at the end of the file the following:
    ```
    "~/.wacom/switch.sh"
    	Control+Shift + Next | m:0x2005 + c:117
    ```
    - replace `~/.wacom/switch.sh` with whatever you moved the script to
    - also, you can replace `Control+Shift + Next | m:0x2005 + c:117` with your keys
        - if you wonder where this line came from you can run `xbindkeys-config`, press `Get Key` and press your combination
- run `xbindkeys --poll-rc` in order to commit the changes
