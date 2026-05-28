#Requires AutoHotkey v2.0
#SingleInstance Force

Initialize()

#Include keyvault\keyvault.ah2
#Include funcs.ah2


; Trigger: Ctrl + Alt + K
^!k::
{
    ToClipboard := False
    Result := ""
    Trace := Arg := ReadChar()

    if (Arg = "y") { ; Yank to clipboard
        ToClipboard := True
        Arg := ReadChar()
        Trace .= " -> " . Arg
    }

    if (IsKvKey(Arg)) {
        Result := KvGet(Arg)
    }

    if (Arg = "F5") {
        return
    }

    if (!Result) {
        TrayTip("Please try again. Trace: " . Trace, "Invalid Key", 3)
        return
    }

    if (ToClipboard) {
        A_Clipboard := Result
    } else {
        Send("{Text}" Result)
    }

    return
}