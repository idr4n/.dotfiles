-- Choose and open bookmark

local bookmarks_file = os.getenv("HOME").."/pCloud/bookmarks"
local bm_num = 0

local bm_chooser = hs.chooser.new(function(choice)
  if not choice then return end
  local bookmark = choice["text"]
  local _, _, url = string.find(bookmark, "(https?://[^ ]+)")
  -- hs.pasteboard.setContents(url)
  os.execute("open "..url)
end)

-- bm_chooser:choices(bookmarks)
bm_chooser:choices(function ()
  local bookmarks = {}
  local num = 1
  for line in io.lines(bookmarks_file) do
    table.insert(bookmarks, {
        ["text"] = line,
        ["num"] = num
      })
    num = num + 1
  end
  table.sort(bookmarks, function(a,b) return a["num"] > b["num"] end)
  bm_num = #bookmarks
  return bookmarks
end)

bm_chooser:width(100)
bm_chooser:rows(18)

bm_chooser:rightClickCallback(function(row)
  local sel_num = bm_num - row + 1
  os.execute("~/.hammerspoon/open_editor".." "..bookmarks_file.." +"..sel_num.." &")
end)

hs.hotkey.bind({"alt", "shift"}, "B", function() 
  bm_chooser:refreshChoicesCallback(true)
  bm_chooser:show(hs.geometry.point(0, 600)) 
  -- print(bookmarks[1]["num"])
end)

