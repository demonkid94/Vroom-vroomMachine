;@Ahk2Exe-AddResource main.ahk, main.ahk
if !FileExist("Data")
	DirCreate "Data"	
	
If !FileExist(A_ScriptDir "\Data\sinners.ini") {
	for n in array("YiSang", "Faust", "Don", "Ryoshu", "Mersault", "HongLu", "Heathcliff", "Ishmael", "Rodion", "Sinclair", "Outis", "Gregor") {
		IniWrite("0", A_ScriptDir "\Data\sinners.ini", A_Index, n)
	}
}

giftsData := ["Blood, Sweat, and Tears", "Bloody Gadget", "Blue Zippo Lighter", "Carmilla", "Child within a Flask", "Coffee and Cranes", "Crown of Roses", "Dreaming Electric Sheep", "Eclipse of Scarlet Moths", "Fiery Down", "Gathering Skulls", "Green Spirit", "Grey Coat", "Grimy Iron Stake", "Hellterfly's Dream", "Homeward", "Illusory Hunt", "Late-bloomer's Tattoo", "Lithograph", "Little and To-be-Naughty Plushie", "Lowest Star", "Melty Eyeball", "Nixie Divergence", "Perversion", "Phantom Pain", "Phlebotomy Pack", "Pinpoint Logic Circuit", "Prejudice", "Rusty Commemorative Coin", "Standard-duty Battery", "Sticky Muck", "Sunshower", "Talisman Bundle", "Thunderbranch", "Today's Expression", "Tomorrow's Fortune", "Voodoo Doll", "White Gossypium", "Wound Clerid"]

If !FileExist(A_ScriptDir "\Data\gifts.ini") || (StrSplit(IniRead(A_ScriptDir "\Data\gifts.ini", "Gifts1"), "`n").length < giftsData.length) {
	for g in array("bloodSweatAndTears", "bloodyGadget", "blueZippoLighter", "carmilla", "childWithinAFlask", "coffeeAndCranes", "crownOfRoses", "dreamingElectricSheep", "eclipseOfScarletMoths", "fieryDown", "gatheringSkulls", "greenSpirit", "greyCoat", "grimyIronStake", "hellterflysDream", "homeward", "illusoryHunt", "lateBloomersTattoo", "lithograph", "littleAndToBeNaughtyPlushie", "lowestStar", "meltyEyeball", "nixieDivergence", "perversion", "phantomPain", "phlebotomyPack", "pinpointLogicCircuit", "prejudice", "rustyCommemorativeCoin", "standardDutyBattery", "stickyMuck", "sunshower", "talismanBundle", "thunderbranch", "todaysExpression", "tomorrowsFortune", "voodooDoll", "whiteGossypium", "woundClerid") {
		try {
			IniRead(A_ScriptDir "\Data\gifts.ini", "Gifts1", g)
		}
		catch {
			IniWrite(giftsData[A_Index], A_ScriptDir "\Data\gifts.ini", "Gifts1", g)
		}
	}
}

sinners := []
sinnersR := []
Loop 12 {
	a := StrSplit(IniRead(A_ScriptDir "\Data\sinners.ini", A_Index), "=")
	sinners.push(a[1])
	sinnersR.push(a[2])
}

gifts := []
giftsNames := []
giftsOrder := StrSplit(IniRead(A_ScriptDir "\Data\gifts.ini", "Gifts1"), "`n")
for g in giftsOrder {
	a := StrSplit(g, "=")
	gifts.push(a[1])
	giftsNames.push(a[2])
}

start := Gui(, "Vroom-vroom Machine v0.2")
tab1 := start.Add("Tab3",, ["Info","Sinners","EGO Gifts"])

start.Add("Text", "vText1", "Mirror Dungeon Script v0.2 a.k.a. Vroom-vroom Machine by KhryDL#2396`n`nThis script is theoretically capable of automatically clearing all the dungeon up untill the last boss`n`nRead the readme.txt file for more info on how to properly test this script")
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
start.addtext("ys w50 vOrder1", "Pick Order")

For g in giftsNames {
	if A_Index > 1 && Mod(A_Index, 20) == 1 {
		start["Order" A_Index - 20].GetPos(&x, &y)
		start.addtext("y" y " x" x + 150 " Section w200", "Gift")
		start.addtext("ys w50 vOrder" A_Index, "Pick Order")
	}
		start.addtext("xs section w200 vGiftName" A_index, g)
		start.addtext("ys hidden w0 vGift" A_index, gifts[A_Index])
		start.addtext("ys w30 vGiftRow" A_index, A_index)
		start.addbutton("ys-5 vGiftUp" A_index, "Up").OnEvent("Click", moveUpG.Bind(A_index))
		start.addbutton("ys-5 vGiftDown" A_index, "Down").OnEvent("Click", moveDownG.Bind(A_index))

}
start["GiftName21"].GetPos(&x, )
start["GiftName17"].GetPos(, &y)
start.addbutton("y" y " x" x * Ceil(giftsData.length / 20) " w100 h100", "Save Changes").OnEvent("Click", saveGifts)

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
		giftName := start["GiftName" row].text
		gift := start["Gift" row].text
		start["GiftName" row].text := start["GiftName" row - 1].text
		start["Gift" row].text := start["Gift" row - 1].text
		start["GiftName" row - 1].text := giftName
		start["Gift" row - 1].text := gift
	}
}

moveDownG(row, *) {
	If row == giftsData.length
		Return
	Else {
		giftName := start["GiftName" row].text
		giftD := start["Gift" row].text
		start["GiftName" row].text := start["GiftName" row + 1].text
		start["Gift" row].text := start["Gift" row + 1].text
		start["GiftName" row + 1].text := giftName
		start["Gift" row + 1].text := giftD
	}	
}

saveGifts(*) {
	IniDelete(A_ScriptDir "\Data\gifts.ini", "Gifts1")
	Loop giftsData.length {
		IniWrite(start["GiftName" A_Index].text, A_ScriptDir "\Data\gifts.ini", "Gifts1", start["Gift" A_Index].text)
	}
}