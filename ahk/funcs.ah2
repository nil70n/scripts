#Requires AutoHotkey v2.0
#SingleInstance Force

Initialize() {
    currentDir := ""
    SplitPath(A_LineFile, , &currentDir)

    SetWorkingDir(currentDir)
    LoadDotEnv()
}

ReadChar() {
    ih := InputHook("L1 T3")
    ih.Start()
    ih.Wait()
    return ih.Input
}

LoadDotEnv() {
    
    TrayTip(A_WorkingDir)
    For line in StrSplit(FileRead("..\.env"), "`n", "`r") {
        if (line = "" || SubStr(line, 1, 1) = "#")
            continue
        eq := InStr(line, "=")
        if !eq
            continue
        EnvSet(Trim(SubStr(line, 1, eq-1)), Trim(SubStr(line, eq+1)))
    }
}