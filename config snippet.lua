------------------------------------------------------------------------------------------
-- MS TEAMS Push-To-Talk
-- timginter @ GitHub
------------------------------------------------------------------------------------------

local pushToTalk = false
local suppressFnKey = false
local suppressMouseForward = true

local sendToAllTeamsWindows = false

------------------------------------------------------------------------------------------

local muteKeyPressed = false

function sendMuteKey(application)
    hs.eventtap.event.newKeyEvent(hs.keycodes.map.shift, true):post(application)
    hs.eventtap.event.newKeyEvent(hs.keycodes.map.cmd, true):post(application)
    hs.eventtap.event.newKeyEvent(hs.keycodes.map.m, true):post(application)
    hs.eventtap.event.newKeyEvent(hs.keycodes.map.m, false):post(application)
    hs.eventtap.event.newKeyEvent(hs.keycodes.map.shift, false):post(application)
    hs.eventtap.event.newKeyEvent(hs.keycodes.map.cmd, false):post(application)
end

function toggleMsTeamsMute()
    local msTeams = hs.appfinder.appFromName("Microsoft Teams (work or school)")
    if msTeams == nil then
        msTeams = hs.appfinder.appFromName("Microsoft Teams classic")
    end
    if msTeams == nil then
        return
    end

    -- save current main MS Teams window and send mute/unmute to it
    initialMainWindow = msTeams:mainWindow()
    sendMuteKey(msTeams)

    -- stop if not sending mute key to other windows
    if not sendToAllTeamsWindows then
        return
    end

    for key, window in pairs(msTeams:allWindows()) do
        if window:title() == "Microsoft Teams Notification"
            or window == initialMainWindow
            or window:isMinimized() then
            goto continue
        end

        -- make window main and send mute/unmute to it
        window:becomeMain()
        sendMuteKey(msTeams)

        -- no real continue in Lua...
        ::continue::
    end

    -- restore initial main window
    if initialMainWindow ~= nil and msTeams:mainWindow() ~= initialMainWindow then
        initialMainWindow:becomeMain()
    end
end

-- capture mouse button "Forward"
overrideMouseForwardDown = hs.eventtap.new({ hs.eventtap.event.types.otherMouseDown }, function(e)
    -- mouse button "Forward"
    if e:getProperty(hs.eventtap.event.properties['mouseEventButtonNumber']) == 4 then
        -- toggle mute only if pushToTalk is enabled
        if pushToTalk then
            toggleMsTeamsMute()
        end

        -- update pressed status
        muteKeyPressed = true

        return suppressMouseForward
    end
end)
overrideMouseForwardUp = hs.eventtap.new({ hs.eventtap.event.types.otherMouseUp }, function(e)
    -- mouse button "Forward"
    if e:getProperty(hs.eventtap.event.properties['mouseEventButtonNumber']) == 4 then
        toggleMsTeamsMute()

        -- update pressed status
        muteKeyPressed = false

        return suppressMouseForward
    end
end)

-- capture Fn key
overrideFn = hs.eventtap.new({ hs.eventtap.event.types.flagsChanged }, function(e)
    -- only Fn key, KeyDown or KeyUp events
    if e:getType() == 12 and e:getKeyCode() == 63 then
        -- toggle mute only if pushToTalk or KeyUp event
        if pushToTalk or muteKeyPressed then
            toggleMsTeamsMute()
        end

        -- update pressed status
        muteKeyPressed = not muteKeyPressed

        return suppressFnKey
    end
end)

-- start override functions
overrideMouseForwardDown:start()
overrideMouseForwardUp:start()
overrideFn:start()

------------------------------------------------------------------------------------------
-- END OF MS TEAMS Push-To-Talk
------------------------------------------------------------------------------------------
