#!/bin/bash
# funcs.sh
# Common functions for quick access

# Reload AutoHotkey scripts
ahk() {
    # Reload only the ahk.ah2 script
    local ahk_file="$ROOT_DIR/ahk/ahk.ah2"
    local ahk_home="$HOME/Documents/AutoHotkey"

    ahk_reload $ahk_file

    for file in "$ahk_home"/*.ahk; do
        ahk_reload $file
    done
}

# Reload AutoHotkey scripts (specific file)
ahk_reload() {
    # Get just the filename (e.g., MyScript.ahk)
    filename=$(basename "$1")
    win_path=$(cygpath -w "$1")
    
    echo "Reloading: $filename"

    # 3. Kill the existing process for this specific script
    # /FI "WINDOWTITLE eq $filename" targets the specific script window
    taskkill //F //FI "WINDOWTITLE eq $filename*" //T > /dev/null 2>&1

    # 4. Re-launch the script
    # Use 'start' to run it in the background so the bash script doesn't hang
    cmd.exe /c "start /b \"\" \"AutoHotkey.exe\" \"$win_path\" && exit"
}

# Aspire project management
asp() {
    local projects_file root
    projects_file="$ROOT_DIR/projects.json"

    root=$(jq -r --arg name "$2" '.[$name].root' "$projects_file")

    if [ -z "$root" ] || [ "$root" = "null" ]; then
        echo "Error: '$2' not found in $projects_file" >&2
        return 1
    fi

    case "$1" in
        debug)
            aspire run --apphost "$root" --wait-for-debugger --detach
            ;;
        stop)
            pushd "$root"
            aspire stop
            popd
            ;;
        *)
            aspire run --apphost "$root" --detach
            ;;
    esac
}