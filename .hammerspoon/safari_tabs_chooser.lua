-- Choose and open bookmark

local tabsScript = [[
tell application "Safari"
	set winlist to every window
	set docText to ""
	repeat with win in winlist
		set tabcount to number of tabs in win
		repeat with x from 1 to tabcount
			set tabName to name of tab x of win
			set theURL to URL of tab x of win
			set docText to docText & (id of win as integer) & ";" & x & ";" & tabName & ";" & theUrl & "\n"
		end repeat
	end repeat
end tell
return docText
]]

local focusTabScript = [[
tell application "Safari"
	activate
	set index of window id %s to 1
	set current tab of window 1 to tab %s of window 1
end tell
tell application "System Events"
	tell application process "Safari"
		set theWin to first window whose name is "%s"
		set focused of theWin to true
		tell theWin to perform action "AXRaise"
	end tell
end tell
]]

local tabs_chooser = hs.chooser.new(function(choice)
	if not choice then
		return
	end
	local win = choice["win"]
	local tab = choice["tab"]
	local title = choice["text"]
	local focusScript = string.format(focusTabScript, win, tab, title)
	-- print(focusScript)
	hs.osascript.applescript(focusScript)
	-- hs.window.get(title):focus()
end)

tabs_chooser:choices(function()
	local _, result = hs.osascript.applescript(tabsScript)
	-- print(result)
	local lines = {}
	for line in string.gmatch(result, "(.-)\n") do
		table.insert(lines, line)
	end
	local tabs = {}
	for _, tab in pairs(lines) do
		local winID, tabNumber, tabTitle, url = string.match(tab, "(.*);(.*);(.*);(.*)")
		-- print(winID .. ":" .. tabTitle)
		table.insert(tabs, {
			["text"] = tabTitle,
			["subText"] = url,
			["win"] = winID,
			["tab"] = tabNumber,
		})
	end
	return tabs
end)

tabs_chooser:width(55)
tabs_chooser:rows(13)
tabs_chooser:searchSubText(true)

hs.hotkey.bind("alt", "'", function()
	tabs_chooser:refreshChoicesCallback(true)
	tabs_chooser:show()
end)
