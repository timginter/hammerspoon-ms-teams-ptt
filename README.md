# hammerspoon-ms-teams-ptt
Hammerspoon config snippet to enable Push-To-Talk for MS Teams calls even if a Teams call is in the background

Binds "Fn" and "Mouse Forward" buttons to mute/unmute on a MS Teams calls

# Known issues:
- script is sending the mute hotkey to the last active Teams window. Because Teams have multiple windows during a call (one for a call, another for the chat/channels, etc.) if you click on the chat/channels Teams window, mute hotkey will be sent to that window instead of the call. As long as the call window is the last Teams window you clicked, the hotkey will work globally. Fix in progress

# Rudimentary setup:

- `local pushToTalk = [true/false]`
  - if set to `True`, pressing Fn or Mouse Forward will unmute, releasing will mute again.
  - if set to `False`, pressing Fn or Mouse Forward will unmute. Press again to mute.

- `local suppressFnKey = [true/false]`
  - if set to `True`, muting/unmuting Teams with Fn key will not send the Fn key (e.g. Fn+Backspace will no longer work).
  - if set to `False`, muting/unmuting Teams with Fn key will also send the Fn key to the top-most window.

- `local suppressMouseForward = [true/false]`
  - if set to `True`, muting/unmuting Teams with Mouse Forward will not send the Mouse Forward button itself.
  - if set to `False`, muting/unmuting Teams with Mouse Forward will also send the Mouse Forward button to top-most window.

# Installation
- install hammerspoon from http://www.hammerspoon.org/
- click the hammerspoon menubar icon, click `Open Config`
- copy contents of the `config snippet.lua` file into your hammerspoon config
- click the hammerspoon menubar icon, click `Reload Config`
- mute your microphone in an MS Teams call - `Fn` and `Mouse Forward (4)` button will mute/unmute your MS Teams call

# Changelog
- 17/0/2021 - initial release
