#Requires AutoHotkey v2.0
#SingleInstance Force

ReadChar() {
    ih := InputHook("L1 T3")
    ih.Start()
    ih.Wait()
    return ih.Input
}

LoadDotEnv(path) {
    For line in StrSplit(FileRead(path), "`n", "`r") {
        if (line = "" || SubStr(line, 1, 1) = "#")
            continue
        eq := InStr(line, "=")
        if !eq
            continue
        EnvSet(Trim(SubStr(line, 1, eq-1)), Trim(SubStr(line, eq+1)))
    }
}