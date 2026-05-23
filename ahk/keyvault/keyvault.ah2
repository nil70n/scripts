#Requires AutoHotkey v2.0
#SingleInstance Force

#Include load.ah2
#Include maps.ah2
#Include ..\funcs.ah2

DevKv := Map()
TstKv := Map()

KvLoad()

KvLoad() {
    global DevKv := GetKvValueMap("d")
    global TstKv := GetKvValueMap("t")
    SetTimer(() => KvLoad(), 3600000 * EnvGet("SLEEP_HOURS")) ; Refresh every hour
}

IsKvKey(key) => SecretMap.Has(key) || VaultMap.Has(key)

KvGet(arg) {
    valueMap := DevKv

    if (arg = "t") {
        valueMap := TstKv
        arg := ReadChar()
    } else if (arg = "d") {
        arg := ReadChar()
    }

    return valueMap[arg]
}