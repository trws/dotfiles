local application = hs.application
local hotkey = hs.hotkey
local window = hs.window
local fnutils = hs.fnutils
local screens = hs.screens
local geometry = hs.geometry
local grid = hs.grid
local tiling = hs.window.tiling
local hints = hs.hints

-- set up your instance(s)
-- expose = hs.expose.new(nil,{showThumbnails=false}) -- default windowfilter, no thumbnails
-- expose_app = hs.expose.new(nil,{onlyActiveApplication=true}) -- show windows for the current application
-- expose_space = hs.expose.new(nil,{includeOtherSpaces=false}) -- only windows in the current Mission Control Space
-- expose_browsers = hs.expose.new{'Safari','Google Chrome'} -- specialized expose using a custom windowfilter
-- for your dozens of browser windows :)

hotkey.bind({"cmd", "alt", "ctrl"}, "D", function()
  local win = window.focusedWindow()
  local f = win:frame()
  f.x = f.x + 10
  win:setFrame(f)
end)

local mash = {'alt', 'ctrl'}
local mashshift = {'alt', 'ctrl', 'shift'}

-- then bind to a hotkey
-- hs.hotkey.bind(mash,'e','Expose',function()expose:toggleShow()end)
-- hs.hotkey.bind(mashshift,'e','App Expose',function()expose_app:toggleShow()end)

hints.style = 'vimperator'
hotkey.bind(mash, "g", function() hs.hints.windowHints() end)
hotkey.bind(mashshift, "g", function() hs.hints.windowHints(hs.window.focusedWindow():application():allWindows()) end)

hotkey.bind(mash, "c", function() tiling.cyclelayout() end)
hotkey.bind(mash, "j", function() tiling.cycle(1) end)
hotkey.bind(mash, "k", function() tiling.cycle(-1) end)
--hotkey.bind(mash, "space", function() tiling.promote() end)
hotkey.bind(mash, "f", function() tiling.gotolayout("fullscreen") end)

-- Set grid size.
grid.GRIDWIDTH  = 12
grid.GRIDHEIGHT = 12
grid.MARGINX    = 0
grid.MARGINY    = 0

-- Grid key expariments
hotkey.bind(mash, ';', function() grid.snap(window.focusedWindow()) end)
hotkey.bind(mash, "'", function() fnutils.map(window.visiblewindows(), grid.snap) end)
hotkey.bind(mash,      '=', function() grid.adjustwidth(1) end)
hotkey.bind(mash,      '-', function() grid.adjustwidth(-1) end)
hotkey.bind(mashshift, '=', function() grid.adjustheight(1) end)
hotkey.bind(mashshift, '-', function() grid.adjustheight(-1) end)

-- hotkey.bind(mash, 'N', grid.pushwindow_nextscreen)
-- hotkey.bind(mash, 'P', grid.pushwindow_prevscreen)

hotkey.bind(mash, 'J', grid.pushWindowDown)
hotkey.bind(mash, 'K', grid.pushWindowUp)
hotkey.bind(mash, 'H', grid.pushWindowLeft)
hotkey.bind(mash, 'L', grid.pushWindowRight)


hotkey.bind({'cmd', 'ctrl'}, 'W', function()
    local all = window.allWindows()
    for _, w in ipairs(all) do
        print("checking window: " .. w:title())
        if string.find(w:title(), 'vit') then
            w:focus()
            break
        end
    end
end)


--
-- Window focus hotkeys
-- hotkey.bind(mash, "H", function()
--   -- local new_rect = geometry.rect(x=0, y=0, w=0.5, h=1.0)
--   window.focusedWindow():focuswindow_west()
-- end)
-- hotkey.bind(mash, "L", function()
--   window.focusedWindow():focuswindow_east()
-- end)
-- hotkey.bind(mash, "K", function()
--   window.focusedWindow():focuswindow_north()
-- end)
-- hotkey.bind(mash, "J", function()
--   window.focusedWindow():focuswindow_south()
-- end)

-- Window throwing
hotkey.bind(mashshift, "H", function()
  -- local new_rect = geometry.rect(x=0, y=0, w=0.5, h=1.0)
  window.focusedWindow():moveToUnit(geometry.rect(0.0, 0.0, 0.5, 1.0))
end)
hotkey.bind(mashshift, "L", function()
  local w = window.focusedWindow()
  w:moveToUnit(geometry.rect(0.5, 0.0, 0.5, 1.0))
end)
hotkey.bind(mashshift, "K", function()
  window.focusedWindow():moveToUnit(geometry.rect(0.0, 0.0, 1.0, 0.5))
end)
hotkey.bind(mashshift, "J", function()
  window.focusedWindow():moveToUnit(geometry.rect(0.0, 0.5, 1.0, 0.5))
end)

move_to_screen = function(target_screen)
  if target_screen ~= nil then
    local w = window.focusedWindow()
    local s = w:screen()
    local f = w:frame()
    f.x = target_screen:fullFrame().x + target_screen:fullFrame().w * ((f.x - s:fullFrame().x) / s:fullFrame().w)
    f.y = target_screen:fullFrame().y + target_screen:fullFrame().w * ((f.y - s:fullFrame().y) / s:fullFrame().w)

    w:setFrame(f)
  end
end

hotkey.bind(mashshift, "1", function()
  window.focusedWindow():moveToUnit(geometry.rect(0.0, 0.0, 1/3, 1.0))
  -- move_to_screen(screens:allScreens()[2])
end)
hotkey.bind(mashshift, "2", function()
  window.focusedWindow():moveToUnit(geometry.rect(1/3, 0.0, 1/3, 1.0))
  -- move_to_screen(screens:allScreens()[1])
end)
hotkey.bind(mashshift, "3", function()
  window.focusedWindow():moveToUnit(geometry.rect(2/3, 0.0, 1/3, 1.0))
  -- move_to_screen(screens:allScreens()[3])
end)

hotkey.bind(mashshift, "Left", function()
  move_to_screen(window.focusedWindow():screen():toWest())
end)

hotkey.bind(mashshift, "Right", function()
  move_to_screen(window.focusedWindow():screen():toEast())
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

hotkey.bind(mashshift, "S", function()
  enable_modal_hotkeys(s_modal_hotkeys)
end)


-- modal keys

table.insert(modal_hotkeys,
hotkey.bind({}, "R", function()
  hs.reload()
end))

-- maximize
table.insert(modal_hotkeys,
hotkey.bind({}, "M", function()
  disable_modal_hotkeys()
  window.focusedWindow():maximize()
end))

-- resize
table.insert(modal_hotkeys,
hotkey.bind({}, "K", function()
  disable_modal_hotkeys()
  local w = window.focusedWindow()
  local f = w:frame()
  f.h = f.h/2
  w:setFrame(f)
end))
table.insert(modal_hotkeys,
hotkey.bind({}, "J", function()
  disable_modal_hotkeys()
  local w = window.focusedWindow()
  local f = w:frame()
  f.y = f.y + f.h / 2
  f.h = f.h / 2
  w:setFrame(f)
end))
table.insert(modal_hotkeys,
hotkey.bind({}, "H", function()
  disable_modal_hotkeys()
  local w = window.focusedWindow()
  local f = w:frame()
  f.w = f.w/2
  w:setFrame(f)
end))
table.insert(modal_hotkeys,
hotkey.bind({}, "L", function()
  disable_modal_hotkeys()
  local w = window.focusedWindow()
  local f = w:frame()
  f.x = f.x + f.w / 2
  f.w = f.w / 2
  w:setFrame(f)
end))

-- Move a screen left and maximize

table.insert(modal_hotkeys,
hotkey.bind({}, "Left", function()
  disable_modal_hotkeys()
  local w = window.focusedWindow()
  local s = w:screen():toWest()
  w:setFrame(s:fullFrame())
end))

table.insert(modal_hotkeys,
hotkey.bind({}, "Right", function()
  disable_modal_hotkeys()
  local w = window.focusedWindow()
  local s = w:screen():toEast()
  w:setFrame(s:fullFrame())
end))

table.insert(modal_hotkeys,
hotkey.bind({}, "1", function()
  disable_modal_hotkeys()
  move_to_screen(screens:allScreens()[2])
  window.focusedWindow():maximize()
end))

table.insert(modal_hotkeys,
hotkey.bind({}, "2", function()
  disable_modal_hotkeys()
  move_to_screen(screens:allScreens()[1])
  window.focusedWindow():maximize()
end))

table.insert(modal_hotkeys,
hotkey.bind({}, "3", function()
  disable_modal_hotkeys()
  move_to_screen(screens:allScreens()[3])
  window.focusedWindow():maximize()
end))


-- cleanup calls, must be at the end

disable_modal_hotkeys()

