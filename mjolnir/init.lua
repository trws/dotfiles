local application = require "mjolnir.application"
local hotkey = require "mjolnir.hotkey"
local window = require "mjolnir.window"
local fnutils = require "mjolnir.fnutils"
local screens = require "mjolnir.screen"
local geometry = require "mjolnir.geometry"

hotkey.bind({"cmd", "alt", "ctrl"}, "D", function()
  local win = window.focusedwindow()
  local f = win:frame()
  f.x = f.x + 10
  win:setframe(f)
end)

hotkey.bind({"alt", "ctrl"}, "H", function()
  -- local new_rect = geometry.rect(x=0, y=0, w=0.5, h=1.0)
  window.focusedwindow():focuswindow_west()
end)
hotkey.bind({"alt", "ctrl"}, "L", function()
  window.focusedwindow():focuswindow_east()
end)
hotkey.bind({"alt", "ctrl"}, "K", function()
  window.focusedwindow():focuswindow_north()
end)
hotkey.bind({"alt", "ctrl"}, "J", function()
  window.focusedwindow():focuswindow_south()
end)

hotkey.bind({"shift", "alt", "ctrl"}, "H", function()
  -- local new_rect = geometry.rect(x=0, y=0, w=0.5, h=1.0)
  window.focusedwindow():movetounit(geometry.rect(0.0, 0.0, 0.5, 1.0))
end)
hotkey.bind({"shift", "alt", "ctrl"}, "L", function()
  local w = window.focusedwindow()
  w:movetounit(geometry.rect(0.5, 0.0, 0.5, 1.0))
end)
hotkey.bind({"shift", "alt", "ctrl"}, "K", function()
  window.focusedwindow():movetounit(geometry.rect(0.0, 0.0, 1.0, 0.5))
end)
hotkey.bind({"shift", "alt", "ctrl"}, "J", function()
  window.focusedwindow():movetounit(geometry.rect(0.0, 0.5, 1.0, 0.5))
end)

move_to_screen = function(target_screen)
  if target_screen ~= nil then
    local w = window.focusedwindow()
    local s = w:screen()
    local f = w:frame()
    f.x = target_screen:fullframe().x + target_screen:fullframe().w * ((f.x - s:fullframe().x) / s:fullframe().w)
    f.y = target_screen:fullframe().y + target_screen:fullframe().w * ((f.y - s:fullframe().y) / s:fullframe().w)

    w:setframe(f)
  end
end

hotkey.bind({"shift", "alt", "ctrl"}, "1", function()
  window.focusedwindow():movetounit(geometry.rect(0.0, 0.0, 1/3, 1.0))
  -- move_to_screen(screens:allscreens()[2])
end)
hotkey.bind({"shift", "alt", "ctrl"}, "2", function()
  window.focusedwindow():movetounit(geometry.rect(1/3, 0.0, 1/3, 1.0))
  -- move_to_screen(screens:allscreens()[1])
end)
hotkey.bind({"shift", "alt", "ctrl"}, "3", function()
  window.focusedwindow():movetounit(geometry.rect(2/3, 0.0, 1/3, 1.0))
  -- move_to_screen(screens:allscreens()[3])
end)

hotkey.bind({"shift", "alt", "ctrl"}, "Left", function()
  move_to_screen(window.focusedwindow():screen():towest())
end)

hotkey.bind({"shift", "alt", "ctrl"}, "Right", function()
  move_to_screen(window.focusedwindow():screen():toeast())
end)

-- modal hotkey support

modal_hotkeys = {}

enable_modal_hotkeys = function()
  for k,v in pairs(modal_hotkeys) do
    v:enable()
  end
end

disable_modal_hotkeys = function()
  for k,v in pairs(modal_hotkeys) do
    v:disable()
  end
end

hotkey.bind({"shift", "alt", "ctrl"}, "S", function()
  enable_modal_hotkeys(s_modal_hotkeys)
end)


-- modal keys

table.insert(modal_hotkeys,
hotkey.bind({}, "R", function()
  mjolnir.reload()
end))

-- maximize
table.insert(modal_hotkeys,
hotkey.bind({}, "M", function()
  disable_modal_hotkeys()
  window.focusedwindow():maximize()
end))

-- resize
table.insert(modal_hotkeys,
hotkey.bind({}, "K", function()
  disable_modal_hotkeys()
  local w = window.focusedwindow()
  local f = w:frame()
  f.h = f.h/2
  w:setframe(f)
end))
table.insert(modal_hotkeys,
hotkey.bind({}, "J", function()
  disable_modal_hotkeys()
  local w = window.focusedwindow()
  local f = w:frame()
  f.y = f.y + f.h / 2
  f.h = f.h / 2
  w:setframe(f)
end))
table.insert(modal_hotkeys,
hotkey.bind({}, "H", function()
  disable_modal_hotkeys()
  local w = window.focusedwindow()
  local f = w:frame()
  f.w = f.w/2
  w:setframe(f)
end))
table.insert(modal_hotkeys,
hotkey.bind({}, "L", function()
  disable_modal_hotkeys()
  local w = window.focusedwindow()
  local f = w:frame()
  f.x = f.x + f.w / 2
  f.w = f.w / 2
  w:setframe(f)
end))

-- Move a screen left and maximize

table.insert(modal_hotkeys,
hotkey.bind({}, "Left", function()
  disable_modal_hotkeys()
  local w = window.focusedwindow()
  local s = w:screen():towest()
  w:setframe(s:fullframe())
end))

table.insert(modal_hotkeys,
hotkey.bind({}, "Right", function()
  disable_modal_hotkeys()
  local w = window.focusedwindow()
  local s = w:screen():toeast()
  w:setframe(s:fullframe())
end))

table.insert(modal_hotkeys,
hotkey.bind({}, "1", function()
  disable_modal_hotkeys()
  move_to_screen(screens:allscreens()[2])
  window.focusedwindow():maximize()
end))

table.insert(modal_hotkeys,
hotkey.bind({}, "2", function()
  disable_modal_hotkeys()
  move_to_screen(screens:allscreens()[1])
  window.focusedwindow():maximize()
end))

table.insert(modal_hotkeys,
hotkey.bind({}, "3", function()
  disable_modal_hotkeys()
  move_to_screen(screens:allscreens()[3])
  window.focusedwindow():maximize()
end))


-- cleanup calls, must be at the end

disable_modal_hotkeys()

