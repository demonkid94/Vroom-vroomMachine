;@Ahk2Exe-AddResource main.ahk, main.ahk

stats := Map()

If !FileExist(A_ScriptDir "\Data\sinners.ini") {
	for n in array("YiSang", "Faust", "Don", "Ryoshu", "Mersault", "HongLu", "Heathcliff", "Ishmael", "Rodion", "Sinclair", "Outis", "Gregor") {
		IniWrite("0", A_ScriptDir "\Data\sinners.ini", A_Index, n)
	}
}
sinners := []
Loop 12 {
	a := StrSplit(IniRead(A_ScriptDir "\Data\sinners.ini", A_Index), "=")
	sinners.push(a[1])
	stats[a[1]] := A_Index "," a[2]
}

start := Gui()
tab1 := start.Add("Tab3",, ["Info","Sinners","EGO Gifts"])

start.Add("Text", "vText1", "Mirror Dungeon Script v0.1 a.k.a. Vroom-vroom Machine by KhryDL#2396`n`nThis script is theoretically capable of automatically clearing all the dungeon up untill the last boss`n`nAutomatic bossfights are currently disabled as they would conflict with the need to reload the script after every non implemented question mark node`n`nRead the readme.txt file for more info on how to properly test this script")
start.Add("Button", "Default", "Start").OnEvent("Click", runData)

tab1.UseTab(3)
start.addtext(,"soon tm")

tab1.UseTab(2)
start.addtext("Section w70", "Sinner")
start.addtext("ys w50", "Rank")
start.addtext("ys w50", "Pick Order")

For s in sinners {
	n := StrSplit(stats[s], ",")
	start.addtext("xs section w70 vSinner" n[1], s)
	start.addtext("ys w50 vRarity" n[1], n[2])
	start.addtext("ys w30 vRow" n[1], n[1])
	start.addbutton("ys vUp" n[1], "Up").OnEvent("Click", moveUp.Bind(n[1]))
	start.addbutton("ys vDown" n[1], "Down").OnEvent("Click", moveDown.Bind(n[1]))
}

start.addbutton("ys-100 x+10 w100 h100", "Save Changes").OnEvent("Click", saveSinners)

start.Show()

runData(*) {
	run "start.exe /script *main.ahk"
	exitapp
}

moveUp(row, *) {
	If row == 1
		Return
	Else {
		sinner := start["Sinner" row].text
		rarity := start["Rarity" row].text
		start["Sinner" row].Name := "SinnerT"
		start["Rarity" row].Name := "RarityT"
		t := row - 1
		start["SinnerT"].text := start["Sinner" t].text
		start["RarityT"].text := start["Rarity" t].text
		start["Sinner" t].text := sinner
		start["Rarity" t].text := rarity	
		start["SinnerT"].Name := "Sinner" row
		start["RarityT"].Name := "Rarity" row	
	}
}

moveDown(row, *) {
	If row == 12
		Return
	Else {
		sinner := start["Sinner" row].text
		rarity := start["Rarity" row].text
		start["Sinner" row].Name := "SinnerT"
		start["Rarity" row].Name := "RarityT"
		t := row + 1
		start["SinnerT"].text := start["Sinner" t].text
		start["RarityT"].text := start["Rarity" t].text
		start["Sinner" t].text := sinner
		start["Rarity" t].text := rarity	
		start["SinnerT"].Name := "Sinner" row
		start["RarityT"].Name := "Rarity" row	
	}
}

saveSinners(*) {	
	Loop 12 {
		IniDelete(A_ScriptDir "\Data\sinners.ini", A_Index)
		IniWrite(start["Rarity" A_Index].text, A_ScriptDir "\Data\sinners.ini", A_Index, start["Sinner" A_Index].text)
	}
}