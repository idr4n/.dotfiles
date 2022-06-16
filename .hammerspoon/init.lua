require("bookmark_chooser")
require("check_later")
require("espanso_chooser")
require("list_chooser")
local h = require("helper")

-- local variables

local screenMargin = 15
local wingap = 15

-- Functions

-- local resizeMediumCenter = function(app)
--   local win = app:focusedWindow()
--   local f = win:frame()
--   local screen = win:screen()
--   local max = screen:frame()

--   f.x = max.x + (max.w * 0.2)
--   f.y = max.y + (max.h * 0.15)
--   f.w = max.w * 0.6
--   f.h = max.h * 0.7
--   win:setFrame(f)
-- end

-- local centerWindow = function(app)
--   local win = app:focusedWindow()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()
--   local screen = win:screen()
--   local max = screen:frame()

--   f.x = max.x + (max.w - f.w)/2
--   f.y = max.y + (max.h - f.h)/2
--   win:setFrame(f)
-- end

-- Set up
local hyper = { "ctrl", "cmd", "alt" }
local hyper2 = { "shift", "ctrl", "cmd", "alt" }
local hyper3 = { "shift", "ctrl", "cmd" }
local hyper4 = { "shift", "cmd", "alt" }

-- Reload config
hs.hotkey.bind({ "alt", "ctrl" }, "1", function()
	hs.reload()
end)
hs.alert.show("Config loaded")

--------------------------------------------------
-- Move Window (nudging - not resizing)
--------------------------------------------------
-- Moving windows in the following directions:
-- y   k   u
-- h       l
-- b   j   n

local moveUp = function()
	local win = hs.window.focusedWindow()
	local f = win:frame()

	f.y = f.y - 25
	win:setFrame(f)
end
hs.hotkey.bind(hyper2, "K", moveUp, nil, moveUp)

local moveLeft = function()
	local win = hs.window.focusedWindow()
	local f = win:frame()

	f.x = f.x - 50
	win:setFrame(f)
end
hs.hotkey.bind(hyper2, "H", moveLeft, nil, moveLeft)

local moveRight = function()
	local win = hs.window.focusedWindow()
	local f = win:frame()

	f.x = f.x + 50
	win:setFrame(f)
end
hs.hotkey.bind(hyper2, "L", moveRight, nil, moveRight)

local moveDown = function()
	local win = hs.window.focusedWindow()
	local f = win:frame()

	f.y = f.y + 25
	win:setFrame(f)
end
hs.hotkey.bind(hyper2, "J", moveDown, nil, moveDown)

--------------------------------------------------
-- Window Location and Resizing
--------------------------------------------------

-- Move window top-middle of the screen and resize
hs.hotkey.bind(hyper3, "I", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x + (max.w / 4)
	f.y = max.y
	f.w = max.w * 1 / 2
	f.h = max.h * 1 / 2
	win:setFrame(f)
end)

-- Move window bottom-middle of the screen and resize
hs.hotkey.bind(hyper3, "/", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x + (max.w / 4)
	f.y = max.y + screenMargin + wingap + (max.h - screenMargin * 2 - wingap) / 2
	f.w = (max.w - screenMargin * 2 - wingap) / 2
	f.h = (max.h - screenMargin * 2 - wingap) / 2
	win:setFrame(f)
end)

-- Move window center of screen and resize small
hs.hotkey.bind(hyper3, "S", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()
	local proportion = 0.62
	-- local ratio = max.w / max.h
	local ratio = 16 / 9

	if max.h <= 1200 then
		proportion = 0.7
	end

	f.x = max.x + (max.w * (1 - proportion) / 2)
	f.w = max.w * proportion
	f.h = f.w * 1 / ratio
	-- f.y = max.y + (max.h - f.h)/2
	f.y = max.y + (max.h - max.w * 0.8 * 1 / ratio) / 2
	win:setFrame(f)
end)

-- Move window center of screen and resize small
hs.hotkey.bind(hyper3, "A", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()
	local proportion = 0.52
	-- local ratio = max.w / max.h
	local ratio = 16 / 9

	if max.h <= 1200 then
		proportion = 0.6
	end

	f.x = max.x + (max.w * (1 - proportion) / 2)
	f.w = max.w * proportion
	f.h = f.w * 1 / ratio
	-- f.y = max.y + (max.h - f.h)/2
	f.y = max.y + (max.h - max.w * 0.8 * 1 / ratio) / 2
	win:setFrame(f)
end)

-- Move window center of screen and resize for Email writing
hs.hotkey.bind(hyper3, "E", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()
	local proportion = 0.36

	if max.h <= 1200 then
		proportion = 0.45
	end

	f.x = max.x + (max.w * (1 - proportion) / 2)
	f.w = max.w * proportion
	f.h = max.h * 0.80
	-- f.y = max.y + (max.h - f.h)/2
	f.y = max.y + (max.h - max.h * 9 / 10)
	win:setFrame(f)
end)

-- Move window center of screen and resize medium
hs.hotkey.bind(hyper3, "K", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()
	local proportion = 0.7
	-- local ratio = max.w / max.h
	local ratio = 16 / 9

	if max.h <= 1200 then
		proportion = 0.8
	end

	f.x = max.x + (max.w * (1 - proportion) / 2)
	f.w = max.w * proportion
	f.h = f.w * 1 / ratio
	-- f.y = max.y + (max.h - f.h)/2
	f.y = max.y + (max.h - max.w * 0.8 * 1 / ratio) / 2
	win:setFrame(f)
end)

-- Move window center of screen and resize BIG
hs.hotkey.bind(hyper3, "J", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()
	local proportion = 0.8
	-- local ratio = max.w / max.h
	local ratio = 16 / 9

	if max.h <= 1200 then
		proportion = 0.9
	end

	f.x = max.x + (max.w * (1 - proportion) / 2)
	f.w = max.w * proportion
	f.h = f.w * 1 / ratio
	f.y = max.y + (max.h - f.h) / 2
	win:setFrame(f)
end)

-- Move window right (half size of the screen)
hs.hotkey.bind(hyper3, "L", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x + screenMargin + wingap + (max.w - screenMargin * 2 - wingap) / 2
	f.y = max.y + screenMargin
	f.w = (max.w - screenMargin * 2 - wingap) / 2
	f.h = max.h - screenMargin * 2
	win:setFrame(f)
end)

-- Move windown left (half size of the screen)
hs.hotkey.bind(hyper3, "H", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x + screenMargin
	f.y = max.y + screenMargin
	f.w = (max.w - screenMargin * 2 - wingap) / 2
	f.h = max.h - screenMargin * 2
	win:setFrame(f)
end)

-- Move window right bottom
hs.hotkey.bind(hyper3, ".", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x + screenMargin + wingap + (max.w - screenMargin * 2 - wingap) / 2
	f.y = max.y + screenMargin + wingap + (max.h - screenMargin * 2 - wingap) / 2
	f.w = (max.w - screenMargin * 2 - wingap) / 2
	f.h = (max.h - screenMargin * 2 - wingap) / 2
	win:setFrame(f)
end)

-- Move window right - smaller than half horizontal screen
hs.hotkey.bind(hyper, "'", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x + (max.w * 0.6) + wingap / 2
	f.y = max.y + screenMargin
	f.w = max.w * 0.4 - wingap - screenMargin / 2
	f.h = max.h - screenMargin * 2
	win:setFrame(f)
end)

-- Move window left - bigger than half horizontal screen
hs.hotkey.bind(hyper, ";", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x + screenMargin
	f.y = max.y + screenMargin
	f.w = max.w * 0.6 - wingap - screenMargin / 2
	f.h = max.h - screenMargin * 2
	win:setFrame(f)
end)

-- Move window right top
hs.hotkey.bind(hyper3, "O", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x + screenMargin + wingap + (max.w - screenMargin * 2 - wingap) / 2
	f.y = max.y + screenMargin
	f.w = (max.w - screenMargin * 2 - wingap) / 2
	f.h = (max.h - screenMargin * 2 - wingap) / 2
	win:setFrame(f)
end)

-- Move window left bottom
hs.hotkey.bind(hyper3, "M", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()
	local proportion = 0.5

	f.x = max.x + screenMargin
	f.y = max.y + screenMargin + wingap + (max.h - screenMargin * 2 - wingap) * (1 - proportion)
	f.w = (max.w - screenMargin * 2 - wingap) / 2
	f.h = (max.h - screenMargin * 2 - wingap) * proportion
	win:setFrame(f)
end)

-- Move window left top
hs.hotkey.bind(hyper3, "U", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()
	local proportion = 0.5

	f.x = max.x + screenMargin
	f.y = max.y + screenMargin
	f.w = (max.w - screenMargin * 2 - wingap) / 2
	f.h = (max.h - screenMargin * 2 - wingap) * proportion
	win:setFrame(f)
end)

-- Center Window (window resizes to 50% the horizontal size of the screen)
hs.hotkey.bind(hyper3, "C", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x + screenMargin + wingap + (max.w - screenMargin * 2 - wingap) / 4
	f.y = max.y + screenMargin
	f.w = (max.w - screenMargin * 2 - wingap) / 2
	f.h = max.h - screenMargin * 2
	win:setFrame(f)
end)

-- Almost center window, tilted right
hs.hotkey.bind({ "ctrl", "alt" }, ".", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x + max.w / 2.6
	f.y = max.y + screenMargin
	f.w = (max.w - screenMargin * 2 - wingap) / 2
	f.h = max.h - screenMargin * 2
	win:setFrame(f)
end)

-- Center Window (does not resize) both horizontally and vertically
hs.hotkey.bind(hyper4, "C", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()
	local max_ver = max.h * 9 / 10

	if f.h > max_ver then
		f.y = max.y + (max.h - f.h) / 2
	else
		f.y = max.y + (max.h - max_ver)
	end

	f.x = max.x + (max.w - f.w) / 2
	win:setFrame(f)
end)

-- Center Window horizontally (does not resize)
hs.hotkey.bind(hyper, "h", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x + (max.w - f.w) / 2
	win:setFrame(f)
end)

-- Center Window horizontally on top of screen (does not resize)
hs.hotkey.bind(hyper, "t", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x + (max.w - f.w) / 2
	f.y = max.y
	win:setFrame(f)
end)

-- Center Window horizontally on bottom of screen (does not resize)
hs.hotkey.bind(hyper, "b", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x + (max.w - f.w) / 2
	f.y = max.y + (max.h - f.h)
	win:setFrame(f)
end)

-- Move Window far right bottom (does not resize)
hs.hotkey.bind(hyper4, "L", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x + (max.w - f.w)
	f.y = max.y + (max.h - f.h)
	win:setFrame(f)
end)

-- Move Window far left bottom (does not resize)
hs.hotkey.bind(hyper4, "H", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x
	f.y = max.y + (max.h - f.h)
	win:setFrame(f)
end)

-- Full screen
hs.hotkey.bind(hyper3, "F", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x + screenMargin
	f.y = max.y + screenMargin
	f.w = max.w - screenMargin * 2
	f.h = max.h - screenMargin * 2
	win:setFrame(f)
end)

-- Full screen - no borders
hs.hotkey.bind(hyper, "F", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x
	f.y = max.y
	f.w = max.w
	f.h = max.h
	win:setFrame(f)
end)

-------------------------------------------------
-- Focus particular apps
-------------------------------------------------

-- hs.hotkey.bind({"ctrl", "cmd"}, "k", function()
-- centerWindow(hs.application.open("kitty", 2, true))
-- end)

-- hs.hotkey.bind("alt", "1", function()
--   -- hs.application.launchOrFocus("qutebrowser")
--   -- hs.application.launchOrFocus("Google Chrome")
--   hs.application.open("Brave Browser")
-- end)

-- hs.hotkey.bind("alt", "2", function()
--   -- hs.application.launchOrFocus("iTerm")
--   hs.application.open("Brave Browser")
--   -- hs.application.open("Marta")
-- end)

-- hs.hotkey.bind("alt", "3", function()
-- hs.application.launchOrFocus("Visual Studio Code")
-- hs.application.launchOrFocus("Google Chrome")
-- hs.application.launchOrFocus("qutebrowser")
-- end)

-- hs.hotkey.bind({"ctrl", "cmd"}, "s", function()
--   hs.application.launchOrFocus("Sublime Text")
-- end)

-- hs.hotkey.bind({"ctrl", "cmd"}, "f", function()
--   hs.application.launchOrFocus("Firefox")
-- end)

-- hs.hotkey.bind("alt", "0", function()
--   hs.application.launchOrFocus("iTerm")
--   -- hs.application.launchOrFocus("kitty")
-- end)

-------------------------------------------------
-- Show window hints
-------------------------------------------------
-- hs.hints.showTitleThresh = 0
-- hs.hotkey.bind("ctrl", ";", function()
--     hs.hints.windowHints()
-- end)

-------------------------------------------------
-- Focus East, West, North, South window
-------------------------------------------------
hs.hotkey.bind({ "alt", "shift" }, "l", function()
	local win = hs.window.focusedWindow()
	win:focusWindowEast(nil, true)
end)

hs.hotkey.bind({ "alt", "shift" }, "h", function()
	local win = hs.window.focusedWindow()
	win:focusWindowWest(nil, true)
end)

hs.hotkey.bind({ "alt", "shift" }, "j", function()
	local win = hs.window.focusedWindow()
	win:focusWindowSouth(nil, true)
end)

hs.hotkey.bind({ "alt", "shift" }, "k", function()
	local win = hs.window.focusedWindow()
	win:focusWindowNorth(nil, true)
end)

-------------------------------------------------
-- Move window to next display (East or West)
-------------------------------------------------

local function moveWindowNext()
	local win = hs.window.focusedWindow()
	win:moveOneScreenEast(0)
	toggleFullScreen(s)
end

local function moveWindowPrev()
	local win = hs.window.focusedWindow()
	win:moveOneScreenWest(0)
	toggleFullScreen(s)
end

hs.hotkey.bind(hyper3, "right", moveWindowNext)
hs.hotkey.bind(hyper3, "left", moveWindowPrev)

-------------------------------------------------
-- Spawning commands
-------------------------------------------------

-- hs.hotkey.bind({"ctrl", "shift"}, "return", function()
--   -- hs.execute("/usr/local/bin/alacritty -e /Users/ivan/bin/nnn", true)
--   -- hs.execute("open -a iterm -n")
--   os.execute("~/scripts/run_term_fm &")
-- end)

-- hs.hotkey.bind({"ctrl", "shift"}, "B", function()
--   os.execute("~/scripts/launch_browser")
-- end)

hs.hotkey.bind({ "ctrl", "shift" }, "D", function()
	hs.execute("open ~/Downloads")
end)

-------------------------------------------------
-- Window layouts
-------------------------------------------------

local samsungScreen = "S27D590"
local iMacScreen = "iMac"

local applyCodingLayout = function()
	hs.application.launchOrFocus("Visual Studio Code")
	hs.application.launchOrFocus("Google Chrome")
end

local redBorder = false
hs.window.highlight.ui.frameColor = { 1, 0, 0, 0.7 }
hs.window.highlight.ui.frameWidth = 6
hs.window.highlight.ui.isolateColor = { 0, 0, 0, 1 }
-- hs.window.highlight.start()

local redBorderWindow = function()
	if not redBorder then
		hs.window.highlight.ui.overlay = true
		hs.window.highlight.ui.frameColor = { 1, 0, 0, 0.7 }
		hs.window.highlight.ui.overlayColor = { 0, 0, 0, 0.00000001 }
		redBorder = true
	else
		hs.window.highlight.ui.overlay = false
		hs.window.highlight.ui.frameColor = { 1, 0, 0, 0 }
		hs.window.highlight.ui.overlayColor = { 0, 0, 0, 0.4 }
		redBorder = false
	end
end

local isolateWindowMedium = function()
	hs.window.highlight.ui.isolateColor = { 0, 0, 0, 0.5 }
	hs.window.highlight.toggleIsolate()
end

local isolateWindowFull = function()
	hs.window.highlight.ui.isolateColor = { 0, 0, 0, 0.95 }
	hs.window.highlight.toggleIsolate()
end

-- hs.hotkey.bind(hyper, "1", applyCodingLayout)
hs.hotkey.bind(hyper, "1", redBorderWindow)
hs.hotkey.bind(hyper2, "1", isolateWindowMedium)
hs.hotkey.bind(hyper2, "2", isolateWindowFull)

------------- Move window to screen borders -------------

hs.hotkey.bind({ "ctrl", "shift", "alt" }, "right", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	-- f.x = max.x + (max.w - f.w) - screenMargin
	f.x = max.x + (max.w - f.w)
	win:setFrame(f)
end)

hs.hotkey.bind({ "ctrl", "shift", "alt" }, "left", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	-- f.x = max.x + screenMargin
	f.x = max.x
	win:setFrame(f)
end)

hs.hotkey.bind({ "ctrl", "shift", "alt" }, "up", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	-- f.y = max.y + screenMargin
	f.y = max.y
	win:setFrame(f)
end)

hs.hotkey.bind({ "ctrl", "shift", "alt" }, "down", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	-- f.y = max.y + (max.h - f.h) - screenMargin
	f.y = max.y + (max.h - f.h)
	win:setFrame(f)
end)

------------- Increase/decrease window size -------------

-----Increase width and height-----
hs.hotkey.bind({ "ctrl", "alt", "shift" }, "=", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	-- local screen = win:screen()
	-- local max = screen:frame()
	local delta = 0.025
	local incWidth = f.w * delta
	local incHeight = f.h * delta

	f.x = f.x - incWidth / 2
	f.w = f.w + incWidth
	f.h = f.h + incHeight
	f.y = f.y - incHeight / 2
	win:setFrame(f)
end)

-----Decrease width and height-----
hs.hotkey.bind({ "ctrl", "alt", "shift" }, "-", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	-- local screen = win:screen()
	-- local max = screen:frame()
	local delta = 0.025
	local incWidth = f.w * delta
	local incHeight = f.h * delta

	f.x = f.x + incWidth / 2
	f.w = f.w - incWidth
	f.h = f.h - incHeight
	f.y = f.y + incHeight / 2
	win:setFrame(f)
end)

-----Increase height-----
hs.hotkey.bind({ "ctrl", "alt", "shift" }, "u", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local delta = 0.025
	local incHeight = f.h * delta

	f.h = f.h + incHeight
	f.y = f.y - incHeight / 2
	win:setFrame(f)
end)

-----Decrease height-----
hs.hotkey.bind({ "ctrl", "alt", "shift" }, "d", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local delta = 0.025
	local incHeight = f.h * delta

	f.h = f.h - incHeight
	f.y = f.y + incHeight / 2
	win:setFrame(f)
end)

-----Increase width-----
hs.hotkey.bind({ "ctrl", "alt", "shift" }, "j", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local delta = 0.025
	local incWidth = f.w * delta
	local incHeight = f.h * delta

	f.x = f.x - incWidth / 2
	f.w = f.w + incWidth
	win:setFrame(f)
end)

-----Decreasae width-----
hs.hotkey.bind({ "ctrl", "alt", "shift" }, "k", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local delta = 0.025
	local incWidth = f.w * delta
	local incHeight = f.h * delta

	f.x = f.x + incWidth / 2
	f.w = f.w - incWidth
	win:setFrame(f)
end)

--------------------------------------------------------------
-- Shortcuts to lunch, focus, or cycle windows of applications
--------------------------------------------------------------

hs.hotkey.bind("alt", "k", function()
	local name = "Sublime Text"
	local app = hs.application.get(name)
	if not app then
		-- print("launching app...")
		hs.application.launchOrFocus(name)
		return
	end
	h.focusApp(app, name)
end)

hs.hotkey.bind("alt", "1", function()
	-- local name = "Google Chrome"
	-- local name = "Firefox"
	local name = "Safari"
	-- local name = "Brave Browser"
	-- local name = "Microsoft Edge"
	-- local name = "Vivaldi"
	local app = hs.application.get(name)
	-- local app = hs.application.find(name)
	if not app then
		hs.application.launchOrFocus(name)
		return
	end

	h.focusApp(app, name)
end)

-- hs.hotkey.bind("alt", "z", function()
--   local name = "Logseq"
--   -- local app = hs.application.find(name)
--   local app = hs.application.get(name)
--   if not app then
--     hs.application.launchOrFocus(name)
--     return
--   end

--   helper.focusApp(app, name)
-- end)

hs.hotkey.bind("alt", "m", function()
	local name = "finder"
	local app = hs.application.find(name)
	if not app then
		hs.application.launchOrFocus(name)
		return
	end

	h.focusApp(app, name)
end)

hs.hotkey.bind({ "alt", "shift" }, "h", function()
	local name = "code"
	local app = hs.application.find(name)
	if not app then
		hs.application.launchOrFocus("Visual Studio Code")
		return
	end

	h.focusApp(app, "Visual Studio Code")
end)

-- Open alacritty with the right size according to screen
hs.hotkey.bind("ctrl", "return", function()
	hs.execute("open -na alacritty", true)
end)

hs.hotkey.bind({ "alt", "shift" }, "v", function()
	h.open_alacritty("fish -ic nvim")
end)

-- hs.hotkey.bind({"alt", "shift"}, "t", function()
hs.hotkey.bind({ "alt" }, "t", function()
	h.open_alacritty("tmux new-session -A -s W")
end)
