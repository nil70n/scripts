#Requires AutoHotkey v2.0
#SingleInstance Force

VaultMap := Map()
VaultMap["d"] := EnvGet("AKV_DEV")
VaultMap["t"] := EnvGet("AKV_TST")

SecretMap := Map()
SecretMap["p"] := EnvGet("DIS_KC_PWD")
SecretMap["s"] := EnvGet("DIS_KC_SCT")
