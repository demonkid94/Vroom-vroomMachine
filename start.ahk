;@Ahk2Exe-AddResource main.ahk, main.ahk

If !FileExist(A_ScriptDir "\Data\sinners.ini") {
	for n in array("YiSang", "Faust", "Don", "Ryoshu", "Mersault", "HongLu", "Heathcliff", "Ishmael", "Rodion", "Sinclair", "Outis", "Gregor") {
		IniWrite("0", A_ScriptDir "\Data\sinners.ini", A_Index, n)
	}
}

If !FileExist(A_ScriptDir "\Data\gifts.ini") {
	g := ["Blood, Sweat, and Tears", "Bloody Gadget", "Blue Zippo Lighter", "Carmilla", "Child within a Flask", "Coffee and Cranes", "Crown of Roses", "Eclipse of Scarlet Moths", "Fiery Down", "Gathering Skulls", "Green Spirit", "Grey Coat", "Grimy Iron Stake", "Hellterfly's Dream", "Homeward", "Illusory Hunt", "Late-bloomer's Tattoo", "Lithograph", "Little and To-be-Naughty Plushie", "Lowest Star", "Melty Eyeball", "Nixie Divergence", "Perversion", "Phantom Pain", "Phlebotomy Pack", "Pinpoint Logic Circuit", "Prejudice", "Rusty Commemorative Coin", "Standard-duty Battery", "Sticky Muck", "Sunshower", "Talisman Bundle", "Thunderbranch", "Today's Expression", "Tomorrow's Fortune", "Voodoo Doll", "White Gossypium", "Wound Clerid"]
	for n in array("bloodSweatAndTears", "bloodyGadget", "blueZippoLighter", "carmilla", "childWithinAFlask", "coffeeAndCranes", "crownOfRoses", "eclipseOfScarletMoths", "fieryDown", "gatheringSkulls", "greenSpirit", "greyCoat", "grimyIronStake", "hellterflysDream", "homeward", "illusoryHunt", "lateBloomersTattoo", "lithograph", "littleAndToBeNaughtyPlushie", "lowestStar", "meltyEyeball", "nixieDivergence", "perversion", "phantomPain", "phlebotomyPack", "pinpointLogicCircuit", "prejudice", "rustyCommemorativeCoin", "standardDutyBattery", "stickyMuck", "sunshower", "talismanBundle", "thunderbranch", "todaysExpression", "tomorrowsFortune", "voodooDoll", "whiteGossypium", "woundClerid") {
		IniWrite(g[A_Index], A_ScriptDir "\Data\gifts.ini", A_Index, n)
	}
	g:= []
}

sinners := []
sinnersR := []
Loop 12 {
	a := StrSplit(IniRead(A_ScriptDir "\Data\sinners.ini", A_Index), "=")
	sinners.push(a[1])
	sinnersR.push(a[2])
}

gifts := []
giftsD := []
Loop 38 {
	a := StrSplit(IniRead(A_ScriptDir "\Data\gifts.ini", A_Index), "=")
	gifts.push(a[2])
	giftsD.push(a[1])
}


start := Gui()
tab1 := start.Add("Tab3",, ["Info","Sinners","EGO Gifts"])

start.Add("Text", "vText1", "Mirror Dungeon Script v0.1 a.k.a. Vroom-vroom Machine by KhryDL#2396`n`nThis script is theoretically capable of automatically clearing all the dungeon up untill the last boss`n`nAutomatic bossfights are currently disabled as they would conflict with the need to reload the script after every non implemented question mark node`n`nRead the readme.txt file for more info on how to properly test this script")
start.Add("Button", "Default", "Start").OnEvent("Click", runData)

tab1.UseTab(2)
start.addtext("Section w70", "Sinner")
start.addtext("ys w50", "Rank")
start.addtext("ys w50", "Pick Order")

For s in sinners {
	start.addtext("xs section w70 vSinner" A_index, s)
	start.addtext("ys w50 vRarity" A_index, sinnersR[A_index])
	start.addtext("ys w30 vSRow" A_index, A_index)
	start.addbutton("ys vUp" A_index, "Up").OnEvent("Click", moveUp.Bind(A_index))
	start.addbutton("ys vDown" A_index, "Down").OnEvent("Click", moveDown.Bind(A_index))
}

start.addbutton("ys-100 x+10 w100 h100", "Save Changes").OnEvent("Click", saveSinners)

tab1.UseTab(3)
start.addtext("Section w200", "Gift")
start.addtext("ys w50", "Pick Order")

For g in gifts {
	if A_Index < 20 {
		start.addtext("xs section w200 vGift" A_index, g)
		start.addtext("ys hidden w0 vGiftD" A_index, giftsD[A_Index])
		start.addtext("ys w30 vGRow" A_index, A_index)
		start.addbutton("ys vGUp" A_index, "Up").OnEvent("Click", moveUpG.Bind(A_index))
		start.addbutton("ys vGDown" A_index, "Down").OnEvent("Click", moveDownG.Bind(A_index))
	}
	Else {
		start["GDown" A_Index - 19].GetPos(&x, &y)
		start.addtext("y" y " x" x + 50 " section w200 vGift" A_index, g)
		start.addtext("ys section hidden w0 vGiftD" A_index, giftsD[A_Index])
		start.addtext("ys w30 vGRow" A_index, A_index)
		start.addbutton("ys vGUp" A_index, "Up").OnEvent("Click", moveUpG.Bind(A_index))
		start.addbutton("ys vGDown" A_index, "Down").OnEvent("Click", moveDownG.Bind(A_index))
		
	}
}

start.addbutton("ys-100 x+10 w100 h100", "Save Changes").OnEvent("Click", saveGifts)

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
		start["Sinner" row].text := start["Sinner" row - 1].text
		start["Rarity" row].text := start["Rarity" row - 1].text
		start["Sinner" row - 1].text := sinner
		start["Rarity" row - 1].text := rarity
	}
}

moveDown(row, *) {
	If row == 12
		Return
	Else {
		sinner := start["Sinner" row].text
		rarity := start["Rarity" row].text
		start["Sinner" row].text := start["Sinner" row + 1].text
		start["Rarity" row].text := start["Rarity" row + 1].text
		start["Sinner" row - 1].text := sinner
		start["Rarity" row - 1].text := rarity
	}
}

saveSinners(*) {	
	Loop 12 {
		IniDelete(A_ScriptDir "\Data\sinners.ini", A_Index)
		IniWrite(start["Rarity" A_Index].text, A_ScriptDir "\Data\sinners.ini", A_Index, start["Sinner" A_Index].text)
	}
}

moveUpG(row, *) {
	If row == 1
		Return
	Else {
		gift := start["Gift" row].text
		giftD := start["GiftD" row].text
		start["Gift" row].text := start["Gift" row - 1].text
		start["GiftD" row].text := start["GiftD" row - 1].text
		start["Gift" row - 1].text := gift
		start["GiftD" row - 1].text := giftD
	}
}

moveDownG(row, *) {
	If row == 38
		Return
	Else {
		gift := start["Gift" row].text
		giftD := start["GiftD" row].text
		start["Gift" row].text := start["Gift" row + 1].text
		start["GiftD" row].text := start["GiftD" row + 1].text
		start["Gift" row + 1].text := gift
		start["GiftD" row + 1].text := giftD
	}	
}

saveGifts(*) {	
	Loop 38 {
		IniDelete(A_ScriptDir "\Data\gifts.ini", A_Index)
		IniWrite(start["Gift" A_Index].text, A_ScriptDir "\Data\gifts.ini", A_Index, start["GiftD" A_Index].text)
	}
}