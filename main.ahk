#Requires AutoHotkey v2.0
#include "tooltip.ahk"
SendMode "Event"

abnos := ["vending", "surgery", "sheep", "mirror", "spider", "slender", "blue", "centipede", "talismans"]
abnos1 := ["purpleGirl", "candle", "bull"]
abnos2 := ["ash"]
abnos3 := ["god", "passenger", "teddy", "steampunkRobot"]

ax := 890
bx := 1030
ay := 180
by := 720
cy := 360
debug := false

+s::
{
	load := 0
	battle := 0
	/*if WinActive("ahk_exe LimbusCompany.exe")
		WinMove -8, -31, 1920+16, 1080+39, "ahk_exe LimbusCompany.exe"
		*/
	out:
	Loop {
		if WinActive("ahk_exe LimbusCompany.exe") {
			;BlockInput "MouseMove"
			MouseMove 1920, 1080
			if ImageSearch(&X, &Y, 1400, 1000, 1420, 1020, A_WorkingDir "\Images\load.png") {
				;MsgBox "load"
				load := 5
			}
			else if load > 0 {
				load -= 1
			}
	
			;auto battle
			else if ImageSearch(&X, &Y, 1748, 39, 1791, 87, "*45 " A_WorkingDir "\Images\pause.png"){
				;MsgBox "pause"
				battle := 10
					Click
					Sleep 500
					Click
					Sleep 500
			}
			else if ImageSearch(&X, &Y, 1830, 120, 1870, 160, "*21 " A_WorkingDir "\Images\target.png") {
				;MsgBox "target"
				battle := 10
					Click
					Sleep 500
					Click
					Sleep 500

				;press "WIN RATE"
				if ImageSearch(&winX, &winY, 1210, 780, 1920, 850, "*110 " A_WorkingDir "\Images\win.png") {
					Click winX, winY
					Sleep 500

					;commit attack
					Click winX - 100, winY
				}
			}
			Else if battle > 0 {
				battle -= 1
			}

			;select sinner
			else if ImageSearch(&X, &Y, 1620, 860, 1760, 880, "*10 " A_WorkingDir "\Images\sinner.png") {
				if debug
					MsgBox "sinner selection"
				Loop 12 {
					a := StrSplit(IniRead(A_ScriptDir "\Data\sinners.ini", A_Index), "=")
					switch a[1] {
						case "YiSang":
							Click 390, 390
						case "Faust":
							Click 640, 390
						case "Don":
							Click 850, 390
						case "Ryoshu":
							click 1080, 390
						case "Mersault":
							click 1290, 390
						case "HongLu":
							click 1520, 390
						case "Heathcliff":
							Click 390, 700
						case "Ishmael":
							Click 640, 700
						case "Rodion":
							Click 850, 700
						case "Sinclair":
							click 1080, 700
						case "Outis":
							click 1290, 700
						case "Gregor":
							click 1520, 700
					}
					Sleep 50
				}

				Click 1620, 860
				Sleep 1000
				Click 960, 550
				Sleep 500
				Click 1620, 860
				Sleep 500
				Click 250, 370
				Sleep 500
				Click 1700, 900
				Sleep 500
				Click 1700, 900
				Sleep 5000
				;Click 950, 800
			}

			;select ego gift
			Else if ImageSearch(&X, &Y, 1600, 850, 1820, 885, "*20 *Transblack " A_WorkingDir "\Images\gift.png") {
				selectGift()
				Sleep 500
				Click X ,Y
				Sleep 1000
			}

			;start battle
			else if ImageSearch(&X, &Y, 1610, 710, 1730, 740, "*10 " A_WorkingDir "\Images\team.png") {
				if debug
					MsgBox "team selection"
				startBattle()
				Sleep 1500
			}

			;press event continue
			else if ImageSearch(&ContinueX, &ContinueY, 1550, 930, 1820, 1010, "*61 " A_WorkingDir "\Images\continue.png") || ImageSearch(&ContinueX, &ContinueY, 1550, 930, 1820, 1010, "*10 " A_WorkingDir "\Images\proceed.png") {
				;MouseMove ContinueX, ContinueY
				;MsgBox "cont"
				Click ContinueX, ContinueY
				Sleep 1500
				Loop 5 {
					MouseClick "WheelDown",,,1
				}
				Sleep 500
				Loop 5 {
					MouseClick "WheelUp",,,1
				}
			}

			;abnormality event
			else if ImageSearch(&X, &Y, 850, 440, 950, 490, "*50 " A_WorkingDir "\Images\skip.png") {
				MsgBox "I haven't implemented all abnormalities events as the way the script is set up requires me to extract part of the starting abnormality screen from an in game image`nWhat to do: Press enter, if the script recognizes the abnormality press enter again, if it doesn't or it gets stuck for more than 5 seconds take a screenshot of the entire screen and put it inside a folder (named after the abnormality or the ego gift it rewards) in https://drive.google.com/drive/folders/1-4nZqkWHOtfIhDMdvLGjT2CoMChdGJHU (as a png).`nIn the same folder put a text file that describes teh steps you have to perform in order to complete the event in the best way possible (refer to this https://docs.google.com/spreadsheets/d/14qQvQ-vpMbJYLNHA32VMqgWgvgVRIhq-ceB_SS6Ieao), using a format similar to this: press skip, press first option, press skip, roll dice, press skip, press skip, press continue"
				event()
			}

			;upgrade characters
			else if ImageSearch(&stageX, &stageY, 480, 405, 1420, 430, "*130 *TransBlack " A_WorkingDir "\Images\stage2.png") || ImageSearch(&stageX, &stageY, 480, 405, 1420, 430, "*130 *TransBlack " A_WorkingDir "\Images\stage3.png") || ImageSearch(&stageX, &stageY, 480, 405, 1420, 430, "*100 *TransBlack " A_WorkingDir "\Images\stage4.png") || ImageSearch(&stageX, &stageY, 480, 405, 1420, 430, "*130 *TransBlack " A_WorkingDir "\Images\stage5.png") {
				;MouseMove stageX, stageY
				if debug
					MsgBox "character upgrade"
				Click stageX, stageY + 50
				Sleep 500
				Click 1200, 800
				Sleep 500
				Click 1000, 790
				Sleep 500
				Click 250, 370
				Sleep 500
				Click 1700, 900
				Sleep 1500
				Click 1200, 800
				Sleep 1500
				Loop 5 {
					MouseClick "WheelDown",,,1
				}
				Sleep 500
				Loop 5 {
					MouseClick "WheelUp",,,1
				}
			}

			;align dante to center
			Else if ImageSearch(&danteX, &danteY, 0, 122, 1920, 1080, "*20 " A_WorkingDir "\Images\dante.png") && danteY > 500 {
				MouseMove danteX, danteY
				MouseClickDrag "Left", 0, 0, 0, 540 - danteY - 50, 10, "r"
			}
			Else if ImageSearch(&danteX, &danteY, 0, 122, 1920, 1080, "*20 " A_WorkingDir "\Images\dante.png") && danteY < 450 {
				MouseMove danteX, danteY
				MouseClickDrag "Left", 0, 0, 0, 540 - danteY + 50, 10, "r"
			}
			Else if ImageSearch(&danteX, &danteY, 0, 122, 1920, 1080, "*20 " A_WorkingDir "\Images\dante.png") && danteX > 1025 {
				MouseMove danteX, danteY
				MouseClickDrag "Left", 0, 0, 960 - danteX - 50, 0, 10, "r"
			}
			Else if ImageSearch(&danteX, &danteY, 0, 122, 1920, 1080, "*20 " A_WorkingDir "\Images\dante.png") && danteX < 895 {
				MouseMove danteX, danteY
				MouseClickDrag "Left", 0, 0, 960 - danteX + 50, 0, 10, "r"
			}

			;press confirm
			else if ImageSearch(&ConfirmX, &ConfirmY, 920, 780, 1060, 820, "*20 " A_WorkingDir "\Images\confirm1.png") {
				Click ConfirmX, ConfirmY
				Loop 5 {
					MouseClick "WheelDown",,,1
				}
				Sleep 500
				Loop 5 {
					MouseClick "WheelUp",,,1
				}
			}

			;boss node			changed boss3 from *15 to *7
			else if ImageSearch(&nodeX, &nodeY, 0, ay, 1920, 1080, "*5 *TransBlack " A_WorkingDir "\Images\boss.png") || ImageSearch(&nodeX, &nodeY, 0, ay, 1920, 1080, "*TransBlack " A_WorkingDir "\Images\boss1.png") || ImageSearch(&nodeX, &nodeY, 0, ay, 1920, 1080, "*8 *TransBlack " A_WorkingDir "\Images\boss2.png") || ImageSearch(&nodeX, &nodeY, 0, ay, 1920, 1080, "*11 *TransBlack " A_WorkingDir "\Images\boss3.png") || ImageSearch(&nodeX, &nodeY, 0, ay, 1920, 1080, "*TransBlack " A_WorkingDir "\Images\boss4.png") {
				MouseMove nodeX, nodeY
				if bossNow(3) {
					MsgBox "If the mouse isn't pointing at the boss node of the 3rd floor take a screenshot of the entire screen, create an issue here https://github.com/KhryDL/Vroom-vroomMachine/issues containing the screenshot (as a png) and a description of the bug (a video is fine too, but the screenshot is required)"
					break out
				}
				bossUp()
				node(nodeX, nodeY)
			}

			;orange node
			else if bossNow(2) && (ImageSearch(&nodeX, &nodeY, 0, 0, ax, 1080, "*2 *TransBlack " A_WorkingDir "\Images\sword.png") || ImageSearch(&nodeX, &nodeY, 0, 0, ax, 1080, A_WorkingDir "\Images\abno.png") || ImageSearch(&nodeX, &nodeY, 0, 0, ax, 1080, "*10 " A_WorkingDir "\Images\event.png") || ImageSearch(&nodeX, &nodeY, 0, 0, ax, 1080, "*10 *TransBlack " A_WorkingDir "\Images\2sword.png")) {
				MouseMove nodeX, nodeY
				if debug
					MsgBox "node found"
				node(nodeX, nodeY)
			}
			else if ImageSearch(&nodeX, &nodeY, bx, 0, 1920, 1080, "*2 *TransBlack " A_WorkingDir "\Images\sword.png") || ImageSearch(&nodeX, &nodeY, bx, 0, 1920, 1080, A_WorkingDir "\Images\abno.png") || ImageSearch(&nodeX, &nodeY, bx, 0, 1920, 1080, "*10 " A_WorkingDir "\Images\event.png") || ImageSearch(&nodeX, &nodeY, bx, 0, 1920, 1080, "*10 *TransBlack " A_WorkingDir "\Images\2sword.png") {
				MouseMove nodeX, nodeY
				if debug
					MsgBox "node found"
				node(nodeX, nodeY)
			}
			;end loop
			Else {
				MsgBox "A bug occurred that prevented the script from knowing what to do next`nWhat to do: Reload and start the script, if it gets stuck again take a screenshot of the entire screen, create an issue here https://github.com/KhryDL/Vroom-vroomMachine/issues containing the screenshot (as a png) and a description of the bug (a video is fine too, but the screenshot is required)"
				Break out
			}
			Sleep 500
		}
		else
			BlockInput "MouseMoveOff"
	}
}

event() {
	boxX := 120
	boxY := 500
	boxXX := 570
	boxYY := 570

	abnoLoop:
	Loop {
		For i In abnos {
			if ImageSearch(&X, &Y, boxX, boxY, boxXX, boxYY, "*100 *TransBlack " A_WorkingDir "\Abnos\" i ".png") {
				MouseMove X, Y
				MsgBox i
				Click 900, 460	;skip
				Sleep 1500
				Click 1440, 330	;first option
				Sleep 1500
				Click 900, 460
				Sleep 500
				Click
				Sleep 500
				Click
				Sleep 500
				Click
				break abnoLoop
			}
		}
		For i In abnos1 {
			if ImageSearch(&X, &Y, boxX, boxY, boxXX, boxYY, "*100 *TransBlack " A_WorkingDir "\Abnos\" i ".png") {
				MouseMove X, Y
				MsgBox i
				Click 900, 460	;skip
				Sleep 1500
				Click 1440, 460	;second option
				Sleep 1500
				Click 900, 460
				Sleep 500
				Click
				Sleep 500
				Click
				break abnoLoop
			}
		}
		For i in abnos2 {
			if ImageSearch(&X, &Y, boxX, boxY, boxXX, boxYY, "*100 *TransBlack " A_WorkingDir "\Abnos\" i ".png") {
				MouseMove X, Y
				MsgBox i
				Click 900, 460	;skip
				Sleep 1500
				Click 1440, 460	;second option
				Sleep 1500
				Click 900, 460
				Sleep 1500
				diceCheck()
				Click 900, 460
				Sleep 500
				Click
				Sleep 500
				Click
				break abnoLoop
			}
		}
		For i in abnos3 {
			if ImageSearch(&X, &Y, boxX, boxY, boxXX, boxYY, "*100 *TransBlack " A_WorkingDir "\Abnos\" i ".png") {
				MouseMove X, Y
				MsgBox i
				Click 900, 460	;skip
				Sleep 1500
				Click 1440, 330	;first option
				Sleep 1500
				Click 1700, 970	;continue
				Sleep 1500
				diceCheck()
				Click 900, 460
				Sleep 500
				Click
				Sleep 500
				Click
				break abnoLoop
			}
		}
		if ImageSearch(&X, &Y, boxX, boxY, boxXX, boxYY, "*100 *TransBlack " A_WorkingDir "\Abnos\gossypium.png") {
				;MouseMove X, Y
				MsgBox "gossypium"
				Click 900, 460	;skip
				Sleep 1500
				Click 1440, 330	;first option
				Sleep 1500
				Click 1700, 970	;continue
				Sleep 1500
				gossypium()
				Click 900, 460
				Sleep 500
				Click
				Sleep 500
				Click
				break abnoLoop
		}
	}
}

diceCheck() {
	Click
	Sleep 2000
	Switch {
		Case PixelSearch(&diceX, &diceY, 70, 898, 970, 923, 0xf7c100):
			MouseMove diceX, diceY
			MsgBox "Check if the script selects the right sinner"
			Click diceX, diceY
		Case PixelSearch(&diceX, &diceY, 70, 898, 970, 923, 0xddb95a, 10):
			MouseMove diceX, diceY
			MsgBox "Check if the script selects the right sinner"
			Click diceX, diceY
		Case PixelSearch(&diceX, &diceY, 70, 898, 970, 923, 0xe9c99f):
			MouseMove diceX, diceY
			MsgBox "Check if the script selects the right sinner"
			Click diceX, diceY
		Case PixelSearch(&diceX, &diceY, 70, 898, 970, 923, 0xfd3333):
			MouseMove diceX, diceY
			MsgBox "Check if the script selects the right sinner"
			Click diceX, diceY
		Case PixelSearch(&diceX, &diceY, 70, 898, 970, 923, 0xd30000):
			MouseMove diceX, diceY
			MsgBox "Check if the script selects the right sinner"
			Click diceX, diceY
		default:
			MsgBox "roll failed"
	}
	Sleep 500
	Click 1700, 960
	Sleep 5000
}

gossypium() {
	Click
	Sleep 2000
	Switch {
		Case PixelSearch(&diceX, &diceY, 70, 898, 970, 923, 0xd30000):
			MouseMove diceX, diceY
			MsgBox "Check if the script selects the right sinner"
			Click diceX, diceY
		Case PixelSearch(&diceX, &diceY, 70, 898, 970, 923, 0xfd3333):
			MouseMove diceX, diceY
			MsgBox "Check if the script selects the right sinner"
			Click diceX, diceY
		Case PixelSearch(&diceX, &diceY, 70, 898, 970, 923, 0xe9c99f):
			MouseMove diceX, diceY
			MsgBox "Check if the script selects the right sinner"
			Click diceX, diceY
		Case PixelSearch(&diceX, &diceY, 70, 898, 970, 923, 0xddb95a, 10):
			MouseMove diceX, diceY
			MsgBox "Check if the script selects the right sinner"
			Click diceX, diceY
		Case PixelSearch(&diceX, &diceY, 70, 898, 970, 923, 0xf7c100):
			MouseMove diceX, diceY
			MsgBox "Check if the script selects the right sinner"
			Click diceX, diceY
		default:
			MsgBox "roll failed"
	}
	Sleep 500
	Click 1700, 960
	Sleep 5000
}

selectGift() {
	;gifts are 210x30 starting from y 280 x 440 860 1275
	Loop {
		a := StrSplit(IniRead(A_ScriptDir "\Data\gifts.ini", A_Index), "=")
		if ImageSearch(&giftX, &giftY, 360, 270, 1550, 320, "*20 " A_WorkingDir "\Gifts\" a[1] ".png") {
			if debug
				MsgBox a[1]
			Click giftX + 105, 420
			Break
		}
	}
}

node(i, o) {
	Click i, o
	Sleep 1000
	Click 1700, 900
	Sleep 1000
}

startBattle() {
	;select party
		if !ImageSearch(&partyX, &partyY, 380, 320, 510, 370, "*80 " A_WorkingDir "\Images\selectedRed.png") {
			Click 380, 320
			Sleep 500
		}
		if !ImageSearch(&partyX, &partyY, 580, 320, 710, 370, "*50 " A_WorkingDir "\Images\selectedRed.png") {
			Click 580, 320
			Sleep 500
		}
		if !ImageSearch(&partyX, &partyY, 780, 320, 910, 370, "*80 " A_WorkingDir "\Images\selectedRed.png") {
			Click 780, 320
			Sleep 500
		}
		if (!ImageSearch(&partyX, &partyY, 980, 320, 1110, 370, "*50 " A_WorkingDir "\Images\selectedRed.png")) {
			Click 980, 320
			Sleep 500
		}
		if (!ImageSearch(&partyX, &partyY, 1170, 320, 1310, 370, "*100 " A_WorkingDir "\Images\selectedRed.png")) {
			Click 1170, 320
			Sleep 500
		}
		if (!ImageSearch(&partyX, &partyY, 1370, 320, 1570, 370, "*100 " A_WorkingDir "\Images\selectedRed.png")) {
			Click 1370, 320
			Sleep 500
		}

		;start battle
		Click 1700, 870
}

+x::
{
	Run "start.exe"
	ExitApp
}

+d::Global debug := !debug
+r::Reload

#SuspendExempt
!s::Suspend