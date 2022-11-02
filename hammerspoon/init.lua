hs.loadSpoon("EmmyLua")
local application = hs.application
local hotkey = hs.hotkey
local window = hs.window
local fnutils = hs.fnutils
-- local screens = hs.screens
local geometry = hs.geometry
local grid = hs.grid
local hints = hs.hints
local json = hs.json
local ipc = require("hs.ipc")
local urle = require("hs.urlevent")
local net = hs.network
local http = hs.http
-- local caf = hs.caffeinate
local cwatch = hs.caffeinate.watcher

local wakewatcher = cwatch.new(function (etype)
  if (etype == cwatch.systemDidWake) then
    hs.execute("podman machine status 2>&1 > /dev/null && podman machine ssh sudo date --set $(date +'%Y-%m-%dT%H:%M:%S')")
  end
  end)

local hs_cfg_path = '~/.hammerspoon'
if not string.find(hs_cfg_path, package.path) then
  package.path = hs_cfg_path .. '/?.lua;' .. package.path
end

local nc_store = net.configuration.open()
local home_hub_ethernet_key = "State:/Network/Interface/en11/Link"
local dhcp_uuid = "C4C5F3A9-4807-49F2-80E8-F45FFC3090A2"
local wifi_uuid = "66F89159-EFE5-4C32-A4E1-B4393A294FB4"

nc_store:monitorKeys(home_hub_ethernet_key, false)
nc_store:setCallback(function(store, _)
  local state = store:contents()
  if state[home_hub_ethernet_key] ~= nil and state[home_hub_ethernet_key]["Active"] then
    print("on hub, switch to dhcp")
    store:setLocation(dhcp_uuid)
  else
    print("not on hub, switch to wifi")
    store:setLocation(wifi_uuid)
  end
end)

nc_store:start()

-- set up your windowfilter
-- local switcher = hs.window.switcher.new() -- default windowfilter: only visible windows, all Spaces
-- local switcher_space = hs.window.switcher.new(hs.window.filter.new():setCurrentSpace(true):setDefaultFilter{}) -- include minimized/hidden windows, current Space only
-- local switcher_browsers = hs.window.switcher.new{'Safari','Google Chrome'} -- specialized switcher for your dozens of browser windows :)

local mash = {'alt', 'ctrl'}
local mashcmd = {'alt', 'ctrl', 'cmd'}
local mashshift = {'alt', 'ctrl', 'shift'}

local bindings = {}
setmetatable(bindings, { __index = table })

local toggle_application = function(bundleID)
  local app = hs.application.get(bundleID)
  if (app and app:isFrontmost()) then
    app:hide()
  else
    hs.application.launchOrFocusByBundleID(bundleID)
  end
end
local toggle_application_nolaunch = function(bundleID)
  local app = hs.application.get(bundleID)
  if (app and app:isFrontmost()) then
    app:hide()
  else
    hs.application.applicationsForBundleID(bundleID)[1]:activate()
  end
end

local enable_bindings = function()
  for k,v in pairs(bindings) do
    v:enable()
  end
end

local disable_bindings = function()
  for k,v in pairs(bindings) do
    v:disable()
  end
end

local screen_sharing_watcher = application.watcher.new(function(name, event, app)
  if(name == "Screen Sharing") then
    if(event == application.watcher.activated) then
      disable_bindings()
    elseif(event == application.watcher.deactivated) then
      enable_bindings()
    end
  end
end)

screen_sharing_watcher:start()

local open_and_focus_with_bundle = function(url, bundleID)
  urle.openURLWithBundle(url, bundleID)
  hs.timer.doAfter(0.2, function()
    hs.application.applicationsForBundleID(bundleID)[1]:activate()
  end)
end

local match_any = function(s, list)
  for k, v in pairs(list) do
    if string.match(s, v) then return true end
  end
  return false
end

urle.httpCallback = function(scheme, host, params, fullURL)
  print("routing URL: " .. fullURL)
  if match_any(fullURL, { "urldefense" }) then
    local prev = ""
    while string.find(fullURL, "urldefense") and fullURL ~= prev do
      prev = fullURL
      local url_parts = http.urlParts(fullURL)
      print("url parts: ", url_parts)
      print(hs.inspect(url_parts))
      if url_parts ~= nil and url_parts.query and url_parts.queryItems[1].u then
        fullURL = url_parts.queryItems[1].u
        fullURL = fullURL:gsub("-", "%%")
        fullURL = fullURL:gsub("_", "/")
        local neturl = require('url')
        fullURL = neturl.decode(fullURL)
        goto continue
      end

      print("removing urldefense garbage, especially *broken* garbage")
      fullURL = fullURL:gsub("^[^_]+__", "")
      fullURL = fullURL:gsub("__.+", "")
      fullURL = fullURL:gsub("*", "#")
      ::continue::
    end
    print("result: " .. fullURL)
  end
  if match_any(fullURL, { "mattermost.energy.gov" }) then
    print("sending to Wavebox")
    open_and_focus_with_bundle(fullURL, 'com.bookry.wavebox')
    return
  end
  if match_any(fullURL, { "webex.com",
        "meet.intel.com",
        "bluejeans.com",
        "zoom.us",
      "llnl.gov" })
    then
    print("sending to Safari")
    open_and_focus_with_bundle(fullURL, 'com.apple.Safari')
    return
  end
  if match_any(fullURL, { "llnl.gov", "teams.microsoft.com" }) then
    print("sending to Wavebox")
    open_and_focus_with_bundle(fullURL, 'com.bookry.wavebox')
    return
  end
  if string.match(fullURL, "nvidia.sharepoint.com") then
    print("sending to Wavebox")
    open_and_focus_with_bundle(fullURL, 'com.bookry.wavebox')
    return
  end
  print("sending to Qute")
  open_and_focus_with_bundle(fullURL, "org.qt-project.Qt.QtWebEngineCore")
end

-- pl = require 'pl.pretty'
-- bindings:insert('a')
-- pl.dump(bindings)

-- bind to hotkeys; WARNING: at least one modifier key is required!
-- hotkey.bind('alt','tab','Next window',function()switcher:next()end)
-- hotkey.bind('alt-shift','tab','Prev window',function()switcher:previous()end)

-- application toggles, formerly alfred bindings
-- bindings:insert(hotkey.bind({"ctrl","cmd"}, "t", function() toggle_application("com.googlecode.iterm2") end))
bindings:insert(hotkey.bind({"ctrl","cmd"}, "m", function() toggle_application_nolaunch("com.webex.meetingmanager") end))
mute_toggle = function()
  app = hs.window.find("Webex Meetings"):application()
  if app:findMenuItem("Mute Me")['enabled'] then
    print("mute me enabled, so mute")
    app:selectMenuItem("Mute Me")
  else
    print("mute me disabled, so unmute")
    app:selectMenuItem("Unmute Me")
  end
end
-- bindings:insert(hotkey.bind(mash, "m", mute_toggle))
-- bindings:insert(hotkey.bind({"ctrl","cmd"}, "g", function() toggle_application("com.google.Chrome") end))
bindings:insert(hotkey.bind({"ctrl","cmd"}, "s", function() toggle_application("com.freron.MailMate") end))
bindings:insert(hotkey.bind({"ctrl","cmd","shift"}, "s", function() toggle_application("com.apple.Safari") end))
bindings:insert(hotkey.bind({"ctrl","cmd"}, "a", function() toggle_application("com.apple.iCal") end))
bindings:insert(hotkey.bind({"ctrl","cmd"}, "b", function() toggle_application("org.qt-project.Qt.QtWebEngineCore") end))
bindings:insert(hotkey.bind({"ctrl","cmd"}, "i", function() toggle_application("com.apple.ActivityMonitor") end))
bindings:insert(hotkey.bind({"ctrl","cmd"}, "e", function() toggle_application("org.gnu.Emacs") end))
bindings:insert(hotkey.bind({"ctrl","cmd"}, "f", function() toggle_application("com.omnigroup.Omnifocus3.macappstore") end))
bindings:insert(hotkey.bind({"ctrl","cmd","shift"}, "l", function() toggle_application("com.electron.logseq") end))
bindings:insert(hotkey.bind({"ctrl","cmd"}, "o", function() toggle_application("com.microsoft.Outlook") end))
bindings:insert(hotkey.bind({"ctrl","cmd"}, "t", function() toggle_application("com.googlecode.iterm2") end))
bindings:insert(hotkey.bind({"ctrl","cmd","shift"}, "v", function() toggle_application("org.vim.macvim") end))
bindings:insert(hotkey.bind({"ctrl","cmd"}, "v", function() toggle_application("com.qvacua.VimR") end))
bindings:insert(hotkey.bind({"ctrl","cmd"}, "w", function() toggle_application("com.bookry.wavebox") end))

-- alternatively, call .nextWindow() or .previousWindow() directly (same as hs.window.switcher.new():next())
-- hs.hotkey.bind('alt','tab','Next window',hs.window.switcher.nextWindow)
-- you can also bind to `repeatFn` for faster traversing
-- hs.hotkey.bind('alt-shift','tab','Prev window',hs.window.switcher.previousWindow,nil,hs.window.switcher.previousWindow)
-- set up your instance(s)
-- expose = hs.expose.new(nil,{showThumbnails=false}) -- default windowfilter, no thumbnails
-- expose_app = hs.expose.new(nil,{onlyActiveApplication=true}) -- show windows for the current application
-- expose_space = hs.expose.new(nil,{includeOtherSpaces=false}) -- only windows in the current Mission Control Space
-- expose_browsers = hs.expose.new{'Safari','Google Chrome'} -- specialized expose using a custom windowfilter
-- for your dozens of browser windows :)

-- set up CLI
ipc.cliInstall()
pws = hs.chooser.new(function(tbl)
  f = io.open(tbl["path"], "w")
  f:write(json.encode(tbl['obj']))
  f:close()
  -- json.write(tbl["obj"], tbl["path"], true, true)
end)
function choose_pw(args)
  choices = {}
  setmetatable(choices, { __index = table })
  js = json.read(args[2])

  for objk,obj in pairs(js) do
    choices:insert({
        ["text"] = (obj["overview"]["title"] or "unknown") .. ": " .. (obj["overview"]["url"] or "unknown"),
        ["path"] = args[3],
        ["obj"] = obj,
      })
  end
  pws:choices(choices)
  pws:show()
end

wins = hs.chooser.new(function(tbl)
  w = hs.window.find(tbl["win"])
  w:focus()
end)
function choose_win()
  win_choices = {}
  setmetatable(win_choices, { __index = table })
  for k,v in pairs(hs.window.allWindows()) do
    app = v:application()
    app_title = app and app:title() or "Unknown"
    if string.len(v:title()) >= 2 then
      win_choices:insert({
          ["text"] = hs.utf8.fixUTF8(v:title() .. " " .. app_title),
          ["win"] = v:id(),
        })
    end
  end
  wins:choices(win_choices)
  wins:show()
end
bindings:insert(hotkey.bind(mash, 'c', choose_win))

-- convert clipboard contents from markdown to rtf
bindings:insert(hotkey.bind(mashshift, 'm', function() hs.execute("pbpaste | ~/scripts/md2clip") end))

bindings:insert(
  hotkey.bind({"cmd", "alt", "ctrl"}, "D", function()
    local win = window.focusedWindow()
    local f = win:frame()
    f.x = f.x + 10
    win:setFrame(f)
  end)
  )

hints.style = 'vimperator'
bindings:insert(hotkey.bind(mash, "g", function() hs.hints.windowHints() end))
bindings:insert(hotkey.bind(mashshift, "g", function() hs.hints.windowHints(hs.window.focusedWindow():application():allWindows()) end))

-- Set grid size.
grid.GRIDWIDTH  = 12
grid.GRIDHEIGHT = 12
grid.MARGINX    = 0
grid.MARGINY    = 0

-- Grid key expariments
bindings:insert(hotkey.bind(mash, '\\', function() grid.show() end))
bindings:insert(hotkey.bind(mash, ';', function() grid.snap(window.focusedWindow()) end))
bindings:insert(hotkey.bind(mash, "'", function() fnutils.map(window.visiblewindows(), grid.snap) end))
bindings:insert(hotkey.bind(mash,      '=', function() grid.resizeWindowWider() end))
bindings:insert(hotkey.bind(mash,      '-', function() grid.resizeWindowThinner() end))
bindings:insert(hotkey.bind(mashshift, '=', function() grid.resizeWindowTaller() end))
bindings:insert(hotkey.bind(mashshift, '-', function() grid.resizeWindowShorter() end))

-- hotkey.bind(mash, 'N', grid.pushwindow_nextscreen)
-- hotkey.bind(mash, 'P', grid.pushwindow_prevscreen)

-- hotkey.bind(mash, 'J', grid.pushWindowDown)
-- hotkey.bind(mash, 'K', grid.pushWindowUp)
-- hotkey.bind(mash, 'H', grid.pushWindowLeft)
-- hotkey.bind(mash, 'L', grid.pushWindowRight)


-- bindings:insert(
-- hotkey.bind({'cmd', 'ctrl'}, 'W', function()
--     local all = window.allWindows()
--     for _, w in ipairs(all) do
--         print("checking window: " .. w:title())
--         if string.find(w:title(), 'vit') then
--             w:focus()
--             break
--         end
--     end
-- end)
-- )

--
-- Window focus hotkeys
bindings:insert(
  hotkey.bind(mashcmd, "H", function()
    -- local new_rect = geometry.rect(x=0, y=0, w=0.5, h=1.0)
    window.focusedWindow():focusWindowWest()
  end)
  )
bindings:insert(
  hotkey.bind(mashcmd, "L", function()
    window.focusedWindow():focusWindowEast()
  end)
  )
bindings:insert(
  hotkey.bind(mashcmd, "K", function()
    window.focusedWindow():focusWindowNorth()
  end)
  )
bindings:insert(
  hotkey.bind(mashcmd, "J", function()
    window.focusedWindow():focusWindowSouth()
  end)
  )
-- Window throwing
bindings:insert(
  hotkey.bind(mashshift, "H", function()
    -- local new_rect = geometry.rect(x=0, y=0, w=0.5, h=1.0)
    window.focusedWindow():moveToUnit(geometry.rect(0.0, 0.0, 0.5, 1.0))
  end)
  )
bindings:insert(
  hotkey.bind(mashshift, "L", function()
    local w = window.focusedWindow()
    w:moveToUnit(geometry.rect(0.5, 0.0, 0.5, 1.0))
  end)
  )
bindings:insert(
  hotkey.bind(mashshift, "K", function()
    window.focusedWindow():moveToUnit(geometry.rect(0.0, 0.0, 1.0, 0.5))
  end)
  )
bindings:insert(
  hotkey.bind(mashshift, "J", function()
    window.focusedWindow():moveToUnit(geometry.rect(0.0, 0.5, 1.0, 0.5))
  end)
  )

bindings:insert(
  hotkey.bind(mashshift, "1", function()
    -- local new_rect = geometry.rect(x=0, y=0, w=0.5, h=1.0)
    window.focusedWindow():moveToUnit(geometry.rect(0.0, 0.0, 1.0/3, 1.0))
  end)
  )
bindings:insert(
  hotkey.bind(mashshift, "2", function()
    -- local new_rect = geometry.rect(x=0, y=0, w=0.5, h=1.0)
    window.focusedWindow():moveToUnit(geometry.rect(1.0/3, 0.0, 1.0/3, 1.0))
  end)
  )
bindings:insert(
  hotkey.bind(mashshift, "3", function()
    -- local new_rect = geometry.rect(x=0, y=0, w=0.5, h=1.0)
    window.focusedWindow():moveToUnit(geometry.rect(2.0/3, 0.0, 1.0/3, 1.0))
  end)
  )

bindings:insert(hotkey.bind(mashshift, "N", function() window.moveToScreen(window.focusedWindow():screen():next()) end))
bindings:insert(hotkey.bind(mashshift, "P", function() window.moveToScreen(window.focusedWindow():screen():previous()) end))

bindings:insert(hotkey.bind(mashshift, "Left", function() window.focusedWindow():moveOneScreenWest() end))
bindings:insert(hotkey.bind(mashshift, "Right", function() window.focusedWindow():moveOneScreenEast() end))
bindings:insert(hotkey.bind(mashshift, "Up", function() window.focusedWindow():moveOneScreenNorth() end))
bindings:insert(hotkey.bind(mashshift, "Down", function() window.focusedWindow():moveOneScreenSouth() end))

-- move_to_screen = function(target_screen)
--   if target_screen ~= nil then
--     local w = window.focusedWindow()
--     local s = w:screen()
--     local f = w:frame()
--     f.x = target_screen:fullFrame().x + target_screen:fullFrame().w * ((f.x - s:fullFrame().x) / s:fullFrame().w)
--     f.y = target_screen:fullFrame().y + target_screen:fullFrame().w * ((f.y - s:fullFrame().y) / s:fullFrame().w)
--
--     w:setFrame(f)
--   end
-- end
--
-- hotkey.bind(mashshift, "Left", function()
--   move_to_screen(window.focusedWindow():screen():toWest())
-- end)
--
-- hotkey.bind(mashshift, "Right", function()
--   move_to_screen(window.focusedWindow():screen():toEast())
-- end)
--
-- hotkey.bind(mashshift, "Down", function()
--   move_to_screen(window.focusedWindow():screen():toSouth())
-- end)
--
-- hotkey.bind(mashshift, "Up", function()
--   move_to_screen(window.focusedWindow():screen():toNorth())
-- end)

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

bindings:insert(
  hotkey.bind(mashshift, "S", function()
    enable_modal_hotkeys(s_modal_hotkeys)
  end)
  )

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

                -- table.insert(modal_hotkeys,
                -- hotkey.bind({}, "1", function()
                --   disable_modal_hotkeys()
                --   move_to_screen(screens:allScreens()[2])
                --   window.focusedWindow():maximize()
                -- end))
                --
                -- table.insert(modal_hotkeys,
                -- hotkey.bind({}, "2", function()
                --   disable_modal_hotkeys()
                --   move_to_screen(screens:allScreens()[1])
                --   window.focusedWindow():maximize()
                -- end))
                --
                -- table.insert(modal_hotkeys,
                -- hotkey.bind({}, "3", function()
                --   disable_modal_hotkeys()
                --   move_to_screen(screens:allScreens()[3])
                --   window.focusedWindow():maximize()
                -- end))

                table.insert(modal_hotkeys,
                  hotkey.bind({}, "1", function()
                    window.focusedWindow():moveToUnit(geometry.rect(0.0, 0.0, 1/3, 1.0))
                    -- move_to_screen(screens:allScreens()[2])
                  end))
                  table.insert(modal_hotkeys,
                    hotkey.bind({}, "2", function()
                      window.focusedWindow():moveToUnit(geometry.rect(1/3, 0.0, 1/3, 1.0))
                      -- move_to_screen(screens:allScreens()[1])
                    end))
                    table.insert(modal_hotkeys,
                      hotkey.bind({}, "3", function()
                        window.focusedWindow():moveToUnit(geometry.rect(2/3, 0.0, 1/3, 1.0))
                        -- move_to_screen(screens:allScreens()[3])
                      end))



                      -- cleanup calls, must be at the end

                      disable_modal_hotkeys()

