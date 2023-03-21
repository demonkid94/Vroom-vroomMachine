Mirror Dungeon Script v0.1 a.k.a. Vroom-vroom Machine by KhryDL#2396

This script is theoretically capable of automatically clearing all the dungeon up to the last boss (excluded)


HOW TO USE:

	In the same folder as this file you will find a gifts.txt file:

		gifts.txt: you can rearrage the content to tell the script which ego gift to choose when given the choice (if you mess up just extract the .7z file again)

	Make sure your game is running at 1920x1080p full screen

	Double-click the "start.exe" file
	
	A GUI will pop up, you will be able to decide the order in which sinners are chosen when given the choice, currently the script only supports 0 sinners and base egos

	Don't press SHIFT + S until you loaded into the dungeon map (the script breaks if it starts during the initial sinner sselection) (it actually doesn't break i just haven't implemented the code to automate this part of the dungeon yet)


HOTKEYS:
	
	SHIFT + S start the script, it will start looking for things to do if a "LimbusCompany.exe" window is currently focussed
		
	SHIFT + R reload the script, use it if the script gets stuck (wait at least 5-7 seconds, sometimes it's just slow others is purposefully slowed down to accomodate for loading times)

	SHIFT + B ups the floor counter by 1, usefull if you need to reload the script at it resets the floor number

	SHIFT + X close the script

	ALT + S enable/disable hotkeys


MESSAGE BOXES

	The script will pause and open a message box in the following occasions, DON'T JUST PRESS ENTER but read what the box says to prevent issues and help me finish the script:

		When a ego gift can be taken:
			I haven't implemented all ego gifts yet as the way the script is set up requires me to extract the ego gift name from an in game image
			What to do: 
				If one of the gifts is:
					Illusory Hunt
					Carmilla
					Standard-duty Battery
					Grimy Iron Stake
					Hellterfly’s Dream 
				take a screenshot of the entire screen and sent it to KhryDL#2396 (as a png)
				otherwise press enter

		When a "question mark" node is entered:
			I haven't implemented all abnormalities events as the way the script is set up requires me to extract part of the starting abnormality screen from an in game image
			What to do: Press enter, if the script recognizes the abnormality press enter again, if if doesn't or it gets stuck for more than 5 seconds take a screenshot of the entire screen and sent it to KhryDL#2396 (as a png)

		When the next node is the last boss node:
			This is actually how the script is intended to work
			If it happens before the final boss node take a screenshot of the entire screen and sent it to KhryDL#2396 (as a png)

		When something goes wrong:
			If the script fails to scan the screen for the next thing to do
			What to do: Reload and start the script, if it gets stuck again take a screenshot of the entire screen and sent it to KhryDL#2396 (as a png)
	
	Every message box will contain all the necessary informations to help improve the script (mostly just taking a screenshot)



