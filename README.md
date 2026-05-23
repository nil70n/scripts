# scripts

Personal automation scripts. The AutoHotkey (AHK) portion under [automation/ahk](automation/ahk) targets **AutoHotkey v2** and ships with VS Code workspace settings that wire up the language server and debugger.

## Prerequisites

| Tool | Version | Purpose |
|---|---|---|
| [AutoHotkey](https://www.autohotkey.com/) | **v2.0+** | Script interpreter |
| [VS Code](https://code.visualstudio.com/) | latest | Editor |
| [`thqby.vscode-autohotkey2-lsp`](https://marketplace.visualstudio.com/items?itemName=thqby.vscode-autohotkey2-lsp) | latest | Language server (completion, diagnostics, formatting) |
| [`zero-plusplus.vscode-autohotkey-debug`](https://marketplace.visualstudio.com/items?itemName=zero-plusplus.vscode-autohotkey-debug) | latest | DBGp debugger |

## Install the AHK v2 interpreter

The workspace expects AHK v2 installed under your user profile at:

```
%USERPROFILE%\AppData\Local\Programs\AutoHotkey\v2\AutoHotkey64.exe
```

This is the default location used by the official AHK installer when installed **for the current user** (not "for all users"). Install via either:

**Winget** (recommended)

```powershell
winget install --id AutoHotkey.AutoHotkey -e
```

**Manual installer** — download from <https://www.autohotkey.com/> and choose the per-user / current-user option during setup.

Verify the path exists:

```powershell
Test-Path "$env:USERPROFILE\AppData\Local\Programs\AutoHotkey\v2\AutoHotkey64.exe"
```

If your install lives elsewhere (e.g. `C:\Program Files\AutoHotkey\v2\`), update the two paths below.

## Install the VS Code extensions

When you open this workspace, VS Code will prompt you to install the recommended extensions from [.vscode/extensions.json](.vscode/extensions.json). To install manually:

```powershell
code --install-extension thqby.vscode-autohotkey2-lsp
code --install-extension zero-plusplus.vscode-autohotkey-debug
```

## How the workspace wires it up

Both [.vscode/settings.json](.vscode/settings.json) and [.vscode/launch.json](.vscode/launch.json) reference the interpreter via the `${env:USERPROFILE}` variable, so the configuration is portable across user accounts on Windows:

[.vscode/settings.json](.vscode/settings.json)

```jsonc
"AutoHotkey2.InterpreterPath": "${env:USERPROFILE}\\AppData\\Local\\Programs\\AutoHotkey\\v2\\AutoHotkey64.exe"
```

[.vscode/launch.json](.vscode/launch.json)

```jsonc
"runtime": "${env:USERPROFILE}\\AppData\\Local\\Programs\\AutoHotkey\\v2\\AutoHotkey64.exe"
```

`*.ahk` and `*.ah2` files are associated with the `ahk2` language so the v2 LSP activates automatically.

### If your interpreter is somewhere else

Edit both files above and replace the path. Common alternatives:

- System-wide install: `C:\\Program Files\\AutoHotkey\\v2\\AutoHotkey64.exe`
- 32-bit interpreter: same folder, `AutoHotkey32.exe`

You can also override per-user without changing the repo by setting the VS Code **user** setting `AutoHotkey2.InterpreterPath` — it takes precedence over the workspace value.

## Running and debugging a script

1. Open any `.ah2` or `.ahk` file.
2. **Run without debugging:** `Ctrl+F5` (or right-click → *Run Script*).
3. **Debug:** press `F5` — picks the *"AHK v2: Run current file"* configuration from [.vscode/launch.json](.vscode/launch.json). Set breakpoints in the gutter as usual.

## Troubleshooting

- **"Interpreter not found"** — confirm the path with the `Test-Path` command above. If the file is missing, reinstall AHK v2 or update the JSON paths.
- **LSP shows v1 syntax errors** — ensure each script starts with `#Requires AutoHotkey v2.0` and the file is recognized as `ahk2` (status bar, bottom right).
- **Changes to `.vscode/*.json` not applied** — run `Developer: Reload Window` from the command palette.

## Repository layout

```
automation/
  ahk/         AutoHotkey v2 scripts
  bash/        Bash scripts
.vscode/       Workspace settings, launch config, extension recommendations
```
