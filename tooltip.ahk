#Requires AutoHotkey >=2
;#singleinstance force
CoordMode "ToolTip", "Screen"
boss := 1

showTooltip(boss)

showTooltip(b) {
	Gui().Opt("+OwnDialogs")
	Tooltip("Floor: " b "    SHIFT + S: Start script    SHIFT + R: Reload script    SHIFT + B: Floor+1    SHIFT + D: Debug mode    ALT + S: Suspend hotkeys    SHIFT + X: Exit script", 10, 5)
}

+b::
{
	bossUp()
}

bossUp() {
	global
	if boss < 3
		boss += 1
	Else
		boss := 1
	showTooltip(boss)
}

bossNow(n) {
	return boss == n
}

exitTooltip() {
	ExitApp
}