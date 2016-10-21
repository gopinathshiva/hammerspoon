--[[

  HOTKEY SHORTCUTS

  1. CMD + ALT + CTRL + S = OPEN APPLE SCRIPTS FOLDER
  2. CTRL + SHIFT + P = OPEN PROJECTS FOLDER IN NEW FINDER
     CTRL + ALT + P = SET FINDER TARGET TO PROJECTS FOLDER
     CTRL + SHIFT + W = OPEN WALMART FOLDER IN NEW FINDER
     CTRL + ALT + W = SET FINDER TARGET TO WALMART FOLDER
  3. CTRL + F = OPEN FINDER
  4. CTRL + T = OPEN TERMINAL
     CMD + D = DUPLICATE TERMINAL
  5. CTRL + ALT + T = OPEN TERMINAL WRT FIRST FINDER WINDOW
  6. CMD + ALT + N = PING GOOGLE
  7. CMD + CTRL + ALT + P = ACCESSIBILITY PASSWORD SHORTCUT
  8. CMD + P = AUTOPASSWORD ENTER
  9. CMD + CTRL + ALT + LEFT = MOVE WINDOW TO LEFT
  10. CMD + CTRL + ALT + RIGHT = MOVE WINDOW TO RIGHT
  11. CMD + CTRL + ALT + G = CENTER SCREEN
  12. CMD + CTRL + ALT + V = CLIPBOARD PASTE PASSWORD FIELDS
  13. CMD + CTRL + ALT + C = CENTER WINDOW IN A SCREEN
  14. CTRL + W = TOGGLE WIFI
  15. CMD + CTRL + ALT + T = SUDO TERMINAL PASSWORD
  16. CMD + D = DUPLICATE FINDER WINDOW


  ECLIPSE SPECIFIC

  1. CMD + R = RUN
  2. CMD + ALT + R = DEBUG

  WATCHERS

  1. APPLICATION WATCHER
  2. BATTERY WATCHER
  3. WIFI WATCHER
  4. BATTERY WATCHER
  5. CAFFEINATE WATCHER

  TIME TRIGGER

  1. 10 MINUTE TRIGGER TO WIFI CHECK

--]]


NOTIFICATION_TITLE = "Hammerspoon"

hs.hotkey.bind({"cmd","ctrl","alt"}, "s", function()
  local script = [[
    set requiredPath to (path to library folder as text) & "Scripts:Open Folder Scripts:Open Apple Scripts Folder.app"
    run script file requiredPath
  ]]
  ok,result = hs.applescript(script)
  hs.notify.new({title=NOTIFICATION_TITLE, informativeText=result}):send()
end)

hs.hotkey.bind({"ctrl","shift"},"p",function()
  local script = [[
    set requiredPath to (path to library folder as text) & "Scripts:Open Folder Scripts:Open Projects Folder.app"
    run script file requiredPath
  ]]
  hs.applescript(script)
end)

hs.hotkey.bind({"ctrl","alt"},"P",function()
  local script = [[
      tell application "Finder"
      	set the target of the front Finder window to the folder "Projects" of the startup disk
      	select the front Finder window
      end tell
  ]]
  hs.applescript(script)
end)

hs.hotkey.bind({"ctrl","shift"},"w",function()
  local script = [[
    set requiredPath to (path to library folder as text) & "Scripts:Open Folder Scripts:Open Walmart Folder.app"
    run script file requiredPath
  ]]
  hs.applescript(script)
end)

hs.hotkey.bind({"ctrl","alt"},"W",function()
  local script = [[
      tell application "Finder"
      	set the target of the front Finder window to the folder "Walmart" of the folder "Projects" of the startup disk
      	select the front Finder window
      end tell
  ]]
  hs.applescript(script)
end)

hs.hotkey.bind({'ctrl'},'f',function()
  local script = [[
    tell application "Finder"
    	open the startup disk
    	activate it
    end tell
  ]]
  hs.applescript(script)
end)

hs.hotkey.bind({"ctrl"},"T",function()
  script = [[
    tell application "Terminal"
      if not (exists window 1) then reopen
      activate
    end tell
  ]]
  hs.applescript(script)
end)

hs.hotkey.bind({'alt','ctrl'},'t',function()
  local script = [[
    set requiredPath to (path to library folder as text) & "Scripts:Open Folder Scripts:Launch Terminal wrt First Finder.app"
    run script file requiredPath
  ]]
  hs.applescript(script)
end)

hs.hotkey.bind({"alt","cmd"},"N",function()
  local script = [[
    set requiredPath to (path to library folder as text) & "Scripts:Open Folder Scripts:Ping Google.app"
    run script file requiredPath
  ]]
  hs.applescript(script)
end)

hs.hotkey.bind({"cmd","alt","ctrl"},"p",function()
  local script = [[
    set requiredPath to (path to library folder as text) & "Scripts:Open Folder Scripts:Security & Privacy allow.app"
    run script file requiredPath
  ]]
  hs.applescript(script)
end)

hs.hotkey.bind({"cmd"},"p",function()
  local script = [[
    set requiredPath to (path to library folder as text) & "Scripts:Open Folder Scripts:Auto Password Enter.app"
    run script file requiredPath
  ]]
  hs.applescript(script)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd","alt","ctrl"},"c",function()
  local win = hs.window.focusedWindow()
  win:centerOnScreen()
end)

hs.hotkey.bind({"cmd","ctrl","alt"},"g",function()
  local win = hs.window.focusedWindow()
  win:toggleFullScreen()
end)

function reloadConfig(files)
    local doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
local myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.notify.new({title="Hammerspoon", informativeText="Config loaded"}):send()

local caffeine = hs.menubar.new()
function setCaffeineDisplay(state)
    if state then
        caffeine:setTitle("AWAKE")
    else
        caffeine:setTitle("SLEEPY")
    end
end

function caffeineClicked()
    setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end

if caffeine then
    caffeine:setClickCallback(caffeineClicked)
    setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
end

hs.hotkey.bind({"cmd","ctrl","alt"}, "V", function() hs.eventtap.keyStrokes(hs.pasteboard.getContents()) end)

hs.hotkey.bind({"ctrl"},"w",function()
  local wifi_state = not hs.wifi.interfaceDetails().power
  hs.wifi.setPower(wifi_state)
  wifi_state = wifi_state and 'ON' or 'OFF'
  hs.alert.show("WIFI "..wifi_state,0.5)
end)

local eclipse_run_shortcut = hs.hotkey.bind({'cmd'},'r',function()
  local script = [[
    set requiredPath to (path to library folder as text) & "Scripts:App Specific Scripts:Eclipse Run.app"
    run script file requiredPath
  ]]
  hs.applescript(script)
end)

local eclipse_debug_shortcut = hs.hotkey.bind({'cmd',"alt"},'r',function()
  local script = [[
    set requiredPath to (path to library folder as text) & "Scripts:App Specific Scripts:Eclipse Debug.app"
    run script file requiredPath
  ]]
  hs.applescript(script)
end)

eclipse_run_shortcut:disable()
eclipse_debug_shortcut:disable()

local duplicate_finder_shortcut = hs.hotkey.bind({"cmd"},"d",function()
  local script = [[
    set requiredPath to (path to library folder as text) & "Scripts:Open Folder Scripts:Duplicate Finder Window.app"
    run script file requiredPath
  ]]
  hs.applescript(script)
end)

local duplicate_terminal_shortcut = hs.hotkey.bind({"cmd"},"d",function()
  local script = [[
    set requiredPath to (path to library folder as text) & "Scripts:Open Folder Scripts:Duplicate Terminal Window.app"
    run script file requiredPath
  ]]
  hs.applescript(script)
end)

function applicationWatcherCallback(appName, eventType, appObject)

  if (appName == "Eclipse") then
    if (eventType == hs.application.watcher.activated) then
      eclipse_run_shortcut:enable()
      eclipse_debug_shortcut:enable()
    elseif (eventType == hs.application.watcher.deactivated) then
      eclipse_run_shortcut:disable()
      eclipse_debug_shortcut:disable()
    end
  elseif (appName == "Finder") then
    if (eventType == hs.application.watcher.activated) then
      duplicate_finder_shortcut:enable()
    elseif (eventType == hs.application.watcher.deactivated) then
      duplicate_finder_shortcut:disable()
    end
  elseif (appName == "Terminal") then
    if (eventType == hs.application.watcher.activated) then
      duplicate_terminal_shortcut:enable()
    elseif (eventType == hs.application.watcher.deactivated) then
      duplicate_terminal_shortcut:disable()
    end
  end

end

-- Create and start the application event watcher
local app_watcher = hs.application.watcher.new(applicationWatcherCallback)
app_watcher:start()

local battery_charged_notification_sent = false

function batteryWatcherCallback()
  local pct = hs.battery.percentage()
  if not hs.battery.isCharging() and pct and pct < 21 then
      hs.notify.new({title="Hammerspoon", informativeText=string.format(
      "Plug-in the power, only %d%% left!!", pct),setIdImage = "images/battery_low.png"}):send()
  elseif pct == 100.0 and hs.battery.isCharged() then
      if not battery_charged_notification_sent then
        hs.notify.new({title="Hammerspoon",informativeText="Battery charged",setIdImage = "images/battery_full.png"}):send()
        battery_charged_notification_sent = true
      end
  else
      battery_charged_notification_sent = false
  end
end

local btwatcher = hs.battery.watcher.new(batteryWatcherCallback)
btwatcher:start()

function wifi_timer_callback()

  function checkAndDisableWifi()
    hs.timer.doAfter(45, function()
      local current_network = hs.wifi.currentNetwork()
      if current_network == nil then
        disableWifi()
      end
    end)
  end

  function disableWifi()
    hs.wifi.setPower(false)
    hs.notify.new({title="Hammerspoon",informativeText="Disabling wifi due to inactivity",setIdImage = "images/wifi_disconnected.png"}):send()
  end

  local status, data, headers = hs.http.get("http://google.com")
  local wifi_state = hs.wifi.interfaceDetails().power
  local current_network = hs.wifi.currentNetwork()
  if not status == 200 then
    if wifi_state and current_network == nil then
      disableWifi()
    else
      hs.wifi.setPower(true)
      checkAndDisableWifi()
    end
  else
    if wifi_state and current_network == nil then
      disableWifi()
    end
  end
end

--local wifi_timer = hs.timer.doEvery((10*60), wifi_timer_callback)
--wifi_timer:start()

function ssidChangedCallback()
    local newSSID = hs.wifi.currentNetwork()
    if newSSID then
      hs.notify.new({title="Connected to "..newSSID,setIdImage = "images/wifi_connected.png"}):send()
    end
end

wifiWatcher = hs.wifi.watcher.new(ssidChangedCallback)
wifiWatcher:start()

function caffeinate_watcher_callback(evt)
  if hs.caffeinate.watcher.screensDidSleep == evt then
    btwatcher:stop()
    wifiWatcher:stop()
    wifi_timer:stop()
    app_watcher:stop()
    print("Watchers are stopped!")
  elseif hs.caffeinate.watcher.screensDidWake == evt then
    btwatcher:start()
    wifiWatcher:start()
    wifi_timer:start()
    app_watcher:start()
    print("Watchers are started!")
  end
end

local caffeinate_watcher = hs.caffeinate.watcher.new(caffeinate_watcher_callback)
caffeinate_watcher:start()
caffeinate_watcher:stop()

hs.hotkey.bind({"cmd","ctrl","alt"},"t",function()
  local script = [[
    set requiredPath to (path to library folder as text) & "Scripts:Open Folder Scripts:Sudo Terminal Password.app"
    run script file requiredPath
  ]]
  hs.applescript(script)
end)


-- KEYSTROKES

hs.hotkey.bind({"alt"},"d",function()
  hs.eventtap.keyStrokes(os.date("%B %d, %Y"))
end)


-- TEXT EXPANDER


keywords = {
    ["date"] = function() return os.date("%B %d, %Y") end,
    ["name"] = "my name is MISTER",
    ["a b"] = "abcd"
}

expander = hs.hotkey.bind({"alt"}, "f", nil, function() -- don't start watching until the keyUp -- don't want to capture an "extra" key at the begining
    local what = ""
    local keyMap = require"hs.keycodes".map -- shorthand... in a formal implementation, I'd do the same for all `hs.XXX` references, but that's me
    local keyWatcher

    hs.timer.doAfter(8, function()
      keyWatcher:stop()
    end)

    keyWatcher = hs.eventtap.new({ hs.eventtap.event.types.keyUp, hs.eventtap.event.types.keyDown }, function(ev)
        local keyCode = ev:getKeyCode()
        local eventType = ev:getType()

        if ev:getFlags().cmd then -- it's part of an application hotkey -- abort!
            keyWatcher:stop()
            return false
        end

        if eventType == hs.eventtap.event.types.keyDown then
            -- these might end capturing, so handle them on the key down since it comes first
            if keyCode == keyMap["return"] then
                keyWatcher:stop()
                local output = keywords[what]
                if type(output) == "function" then
                    local _, o = pcall(output)
                    if not _ then
                        print("~~ expansion for '" .. what .. "' gave an error of " .. o)
                        -- could also set o to nil here so that the expansion doesn't occur below, but I think
                        -- seeing the error as the replacement will be a little more obvious that a print to the
                        -- console which I may or may not have open at the time...
                        -- maybe show an alert with hs.alert instead?
                    end
                    output = o
                end
                if output then
                    -- based on the value in `what`, delete over what was typed in and replace it with whatever we want
                    for i = 1, utf8.len(what), 1 do hs.eventtap.keyStroke({}, "delete") end
                    hs.eventtap.keyStrokes(output)
                end
                return true -- don't pass the "return" keystroke on
            elseif keyCode == keyMap["escape"] then
                keyWatcher:stop()
                return true -- don't pass the "escape" keystroke on
            elseif keyCode == keyMap["up"] or keyCode == keyMap["down"] then -- should others be in here?
                keyWatcher:stop()
                return false -- pass these on
            elseif keyCode == keyMap["delete"] and #what == 0 then -- if what is empty then delete will exit the capture
                keyWatcher:stop()
                return true -- don't pass the "delete" keystroke on in this case
            end
        elseif eventType == hs.eventtap.event.types.keyUp then
            if keyCode == keyMap["delete"] then
                if #what > 0 then
                    -- while `what = what:sub(1, #what)` is simpler, it would choke on utf8 characters... so we do this
                    local t = {}
                    for p, c in utf8.codes(what) do table.insert(t, c) end
                    table.remove(t, #t) -- pop off the last one
                    what = utf8.char(table.unpack(t))
                else
                    -- shouldn't be possible with the test in keyDown, but I've been wrong before, so just in case...
                    keyWatcher:stop()
                    return true
                end
            else
              if keyCode ~= keyMap["left"] and keyCode ~= keyMap["right"] then
                local c = ev:getCharacters() -- are we sure this will always return nil if it's not a "printable" character?
                if c then what = what .. c end
              end
            end
        end

        -- if we get here, we've either already captured what we wanted/needed or we don't recognize it;
        -- either way, pass the event on to the focused application for its own use
        return false
    end):start()
end)
