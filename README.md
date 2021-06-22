# hammerspoon-ms-teams-ptt
Hammerspoon config snippet to enable Push-To-Talk for MS Teams calls even if a Teams call is in the background

Binds "Fn" and "Mouse Forward" buttons to mute/unmute on a MS Teams calls

# Known issues:
- with push-to-talk, script may not mute Teams call if you press another mouse button while the mute/unmute mouse button is also pressed - this will reverse push-to-talk into push-to-mute. Mute yourself manually in the Teams call to fix
- if `sendToAllTeamsWindows` is set to `false`, script is sending the mute hotkey to the last active Teams window. Because Teams have multiple windows during a call (one for a call, another for the chat/channels, etc.) if you click on the chat/channels Teams window, mute hotkey will be sent to that window instead of the call. As long as the call window is the last Teams window you clicked, the hotkey will work globally

# Rudimentary setup:
- `local pushToTalk = [true/false]`
  - if set to `true`, pressing Fn or Mouse Forward will unmute, releasing will mute again.
  - if set to `false`, pressing Fn or Mouse Forward will unmute. Press again to mute.

- `local suppressFnKey = [true/false]`
  - if set to `true`, muting/unmuting Teams with Fn key will not send the Fn key (e.g. Fn+Backspace will no longer work).
  - if set to `false`, muting/unmuting Teams with Fn key will also send the Fn key to the top-most window.

- `local suppressMouseForward = [true/false]`
  - if set to `true`, muting/unmuting Teams with Mouse Forward will not send the Mouse Forward button itself.
  - if set to `false`, muting/unmuting Teams with Mouse Forward will also send the Mouse Forward button to top-most window.

- `local sendToAllTeamsWindows = [true/false]`
  - if set to `true`, script will loop through all windows of MS Teams and send the hotkey to each window
  - if set to `false`, script will send the hotkey to the last active window of MS Teams

# Installation
- install hammerspoon from http://www.hammerspoon.org/
- click the hammerspoon menubar icon, click `Open Config`
- copy contents of the `config snippet.lua` file into your hammerspoon config
- click the hammerspoon menubar icon, click `Reload Config`
- mute your microphone in an MS Teams call - `Fn` and `Mouse Forward (4)` button will mute/unmute your MS Teams call
