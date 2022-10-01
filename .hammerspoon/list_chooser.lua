-- Choose and open bookmark

local list_file = os.getenv("HOME") .. "/Dropbox/PSU/List.csv"
local bm_num = 0

local list_chooser = hs.chooser.new(function(choice)
	if not choice then
		return
	end
	local student = choice["text"]
	local _, _, id = string.find(student, "(2%d%d%d%d%d%d%d%d)")
	local email = id .. "@psu.edu.sa"
	hs.pasteboard.setContents(id)
	-- hs.pasteboard.setContents(email)
	-- print("student email:", email)
end)

local function Split(s, delimiter)
	local result = {}
	for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
		table.insert(result, match)
	end
	return result
end

list_chooser:choices(function()
	local students = {}
	local num = 1
	for line in io.lines(list_file) do
		local split = Split(line, ",")
		local new_text = "ID: "
			.. split[1]
			.. ", Name: "
			.. split[2]
			.. ", Course: "
			.. split[3]
			.. ", Section: "
			.. split[4]
		local marks = { table.unpack(split, 5) }
		local marks_string = table.concat(marks, ", ")
		local new_subtext = "Marks: " .. marks_string
		table.insert(students, {
			["text"] = new_text,
			["subText"] = new_subtext,
		})
		num = num + 1
	end

	return students
end)

list_chooser:width(100)
list_chooser:rows(18)

list_chooser:rightClickCallback(function(row)
	os.execute("~/.hammerspoon/open_editor" .. " " .. list_file .. " +" .. row .. " &")
end)

hs.hotkey.bind({ "ctrl", "alt", "shift" }, "L", function()
	list_chooser:refreshChoicesCallback(true)
	list_chooser:show(hs.geometry.point(0, 600))
	-- print(bookmarks[1]["num"])
end)
