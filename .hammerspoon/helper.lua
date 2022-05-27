local h = {}

function h.open_alacritty(exec)
  local e_flag = ''
  if exec then
    e_flag = " -e "..exec
  end

  local screen = hs.screen.mainScreen()
  local max = screen:frame()
  local rows = 0
  local cols = 0

  if max.h == 1415 then
    rows = 60
    cols = 125
  else
    rows = 45
    cols = 83
  end

  local cmd = "open -na alacritty --args "
  local args = "-o window.dimensions.columns="..cols.." -o window.dimensions.lines="..rows..e_flag
  hs.execute(cmd..args, true)
end

function h.focusApp(app, name)
	-- local name = app:title()
	local wins = app:allWindows()
	-- print('windows: ' .. #wins)

	if #wins == 0 then
		app:activate()
		return
	end

	table.sort(wins, function(a, b)
		return a:id() < b:id()
	end)

	local function tablefind(tab, el)
		for index, value in pairs(tab) do
			if value:id() == el then
				-- print("Index of win 0: " .. index)
				return index
			end
		end
	end

	local remove_idx = tablefind(wins, 0)
	if remove_idx then
		table.remove(wins, tablefind(wins, 0))
	end

	local front_win = hs.window.frontmostWindow()

	-- for idx, win in pairs(wins) do
	--   print(idx, win:id(), win)
	-- end

	for idx, win in pairs(wins) do
		-- print(idx, win)
		if front_win == win then
			local newIndex = (idx + 1) > #wins and 1 or idx + 1
			wins[newIndex]:focus()
			return
		end
	end

	hs.application.launchOrFocus(name)
	-- wins[1]:focus()
end

return h
