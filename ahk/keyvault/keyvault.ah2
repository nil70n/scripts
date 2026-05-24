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

    if (!EnvGet("SLEEP_HOURS")) {
        LoadDotEnv()
    }

    SetTimer(() => KvLoad(), 3600000 * Integer(EnvGet("SLEEP_HOURS") || 2))
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