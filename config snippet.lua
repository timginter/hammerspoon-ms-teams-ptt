------------------------------------------------------------------------------------------
-- MS TEAMS Push-To-Talk
-- timginter @ GitHub
------------------------------------------------------------------------------------------

local pushToTalk = true
local suppressFnKey = false
local suppressMouseForward = true

------------------------------------------------------------------------------------------

local muteKeyPressed = false

function toggleMsTeamsMute()
    -- TODO: send keystrokes to call window, not to application (last active window of the app)
    local msTeams = hs.appfinder.appFromName("Microsoft Teams")
    if msTeams ~= nil then
        hs.eventtap.event.newKeyEvent(hs.keycodes.map.shift, true):post(msTeams)
        hs.eventtap.event.newKeyEvent(hs.keycodes.map.cmd, true):post(msTeams)
        hs.eventtap.event.newKeyEvent(hs.keycodes.map.m, true):post(msTeams)
        hs.eventtap.event.newKeyEvent(hs.keycodes.map.m, false):post(msTeams)
        hs.eventtap.event.newKeyEvent(hs.keycodes.map.shift, false):post(msTeams)
        hs.eventtap.event.newKeyEvent(hs.keycodes.map.cmd, false):post(msTeams)
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
