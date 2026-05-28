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

    LoadDotEnv()

    if (EnvGet("KV_AUTO_REFRESH") && EnvGet("KV_AUTO_REFRESH") == "true")
    {
        Interval := EnvGet("KV_AUTO_REFRESH_HOURS") || "2"
        SetTimer(() => KvLoad(), 3600000 * Integer(Interval))
    }
}

IsKvKey(key) => SecretMap.Has(key) || VaultMap.Has(key) || key = "F5"

KvGet(arg) {
    valueMap := DevKv

    if (arg = "F5") {
        KvLoad()
        TrayTip("Secrets Reloaded.", "Key Vault", 4)
        return ""
    } else if (arg = "t") {
        valueMap := TstKv
        arg := ReadChar()
    } else if (arg = "d") {
        arg := ReadChar()
    }

    return valueMap[arg]
}