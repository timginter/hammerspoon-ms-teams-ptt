# MsTeamshammerspoonPtt
Hammerspoon config snippet to enable Push-To-Talk for MS Teams calls

Binds "Fn" and "Mouse Forward" buttons to mute/unmute on a MS Teams calls

# Rudimentary setup:

- `local pushToTalk = [true/false]`
  - If set to `True`, pressing Fn or Mouse Forward will unmute, releasing will mute again.
  - Id set to `False`, pressing Fn or Mouse Forward will unmute. Press again to mute.

- `local suppressFnKey = [true/false]`
  - If set to `True`, muting/unmuting Teams with Fn key will not send the Fn key (e.g. Fn+Backspace will no longer work).
  - Id set to `False`, muting/unmuting Teams with Fn key will also send the Fn key to the top-most window.

- `local suppressMuseForward = [true/false]`
  - If set to `True`, muting/unmuting Teams with Mouse Forward will not send the Mouse Forward button itself.
  - Id set to `False`, muting/unmuting Teams with Mouse Forward will also send the Mouse Forward button to top-most window.
