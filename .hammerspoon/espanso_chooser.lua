-- Choose and copy to clipboard espanso expansion

local ex_chooser = hs.chooser.new(function(choice)
  if not choice then return end
  local expansion = choice["text"]
  hs.pasteboard.setContents(expansion)
end)

ex_chooser:choices(function ()
  local list = hs.execute("/usr/local/bin/espanso match list")
  expansions = {}
  local num = 1
  for line in list:gmatch("([^\n]*)\n?") do
    table.insert(expansions, {
        ["text"] = line,
        ["num"] = num
      })
    num = num + 1
  end
  -- table.sort(expansions, function(a,b) return a["num"] > b["num"] end)
  table.sort(expansions, function(a,b) return a["text"] < b["text"] end)
  return expansions
end)

ex_chooser:width(100)
ex_chooser:rows(18)

hs.hotkey.bind({"alt", "shift"}, "E", function() 
  ex_chooser:refreshChoicesCallback(true)
  ex_chooser:show(hs.geometry.point(0, 600)) 
end)

