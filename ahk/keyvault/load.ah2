#Requires AutoHotkey v2.0
#SingleInstance Force

#Include maps.ah2

GetKvValueMap(vaultKey) {
    valueMap := Map()

    for key, name in SecretMap {
        valueMap[key] := GetKvSecret(VaultMap[vaultKey], name)
    }

    return valueMap
}

GetKvSecret(vaultName, secretName) {
    Shell := ComObject("WScript.Shell")
    Command := A_ComSpec ' /c az keyvault secret show --vault-name "' vaultName '" --name "' secretName '" --query "value" -o tsv'
    
    ; Execute and read the output stream
    Exec := Shell.Exec(Command)
    Result := Exec.StdOut.ReadAll()
    
    ; Clean up trailing line breaks
    return Trim(Result, " `t`n`r")
}