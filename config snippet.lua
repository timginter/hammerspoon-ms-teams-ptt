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
    local msTeams = hs.appfinder.appFromName("Microsoft Teams")
    if msTeams ~= nil then
        hs.eventtap.event.newKeyEvent(hs.keycodes.map.shift, true):post(msTeams)
        hs.eventtap.event.newKeyEvent(hs.keycodes.map.cmd, true):post(msTeams)
        hs.eventtap.event.newKeyEvent(hs.keycodes.map.m, true):post(msTeams)
        hs.eventtap.event.newKeyEvent(hs.keycodes.map.m, false):post(msTeams)
        hs.eventtap.event.newKeyEvent(hs.keycodes.map.shift, false):post(msTeams)
        hs.eventtap.event.newKeyEvent(hs.keycodes.map.cmd, false):post(msTeams)
    end

    -- update pressed status
    muteKeyPressed = not muteKeyPressed
end

-- capture mouse button "Forward"
overrideMouseForwardDown = hs.eventtap.new({ hs.eventtap.event.types.otherMouseDown }, function(e)
    if e:getProperty(hs.eventtap.event.properties['mouseEventButtonNumber']) == 4 then
        toggleMsTeamsMute()

        return suppressMouseForward
    end
end)
overrideMouseForwardUp = hs.eventtap.new({ hs.eventtap.event.types.otherMouseUp }, function(e)
    if e:getProperty(hs.eventtap.event.properties['mouseEventButtonNumber']) == 4 then-- suppress keyUp event if pushToTalk disabled
        -- suppress keyUp event if pushToTalk disabled
        if not pushToTalk and muteKeyPressed then
            -- update pressed status
            muteKeyPressed = not muteKeyPressed

            return suppressMouseForward
        end

        toggleMsTeamsMute()

        return suppressMouseForward
    end
end)

-- capture Fn key
overrideFnForTeamsMute = hs.eventtap.new({ hs.eventtap.event.types.flagsChanged }, function(e)
    -- Fn key Down or Up
    if e:getType() == 12 and e:getKeyCode() == 63 then
        -- suppress keyUp event if pushToTalk disabled
        if not pushToTalk and muteKeyPressed then
            -- update pressed status
            muteKeyPressed = not muteKeyPressed

            return suppressFnKey
        end

        toggleMsTeamsMute()
        
        return suppressFnKey
    end
end)

-- start override functions
overrideMouseForwardDown:start()
overrideMouseForwardUp:start()
overrideFnForTeamsMute:start()

------------------------------------------------------------------------------------------
-- END OF MS TEAMS Push-To-Talk
------------------------------------------------------------------------------------------
