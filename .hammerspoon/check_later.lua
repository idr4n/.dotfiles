-- Check tasks

local tasks_file = os.getenv("HOME").."/pCloud/check_later"
local tasks_num = 0

local task_chooser = hs.chooser.new(function(choice)
  if not choice then return end
  local task = choice["text"]
  local _, _, url = string.find(task, "(https?://[^ ]+)")
  if url then
    hs.pasteboard.setContents(url)
    os.execute("open "..url)
  else
    return
  end
end)

task_chooser:choices(function()
  local tasks = {}
  local num = 1
  for line in io.lines(tasks_file) do
    table.insert(tasks, {
        ["text"] = line,
        ["num"] = num
      })
    num = num + 1
  end
  table.sort(tasks, function(a,b) return a["num"] > b["num"] end)
  tasks_num = #tasks
  return tasks
end)

task_chooser:width(100)
task_chooser:rows(18)

task_chooser:rightClickCallback(function(row)
  local sel_num = tasks_num - row + 1
  os.execute("~/.hammerspoon/open_editor".." "..tasks_file.." +"..sel_num.." &")
end)

hs.hotkey.bind({"alt", "shift"}, "C", function() 
  task_chooser:show(hs.geometry.point(0, 600)) 
  task_chooser:refreshChoicesCallback(true)
end)
