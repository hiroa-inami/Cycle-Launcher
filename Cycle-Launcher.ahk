#Requires AutoHotkey v2.0+
;https://github.com/hiroa-inami/Cycle-Launcher
;https://www.autohotkey.com/docs/v2/Hotkeys.htm#Symbols
;https://www.autohotkey.com/docs/v2/KeyList.htm
;https://www.autohotkey.com/docs/v2/misc/WinTitle.htm
;https://cs.lmu.edu/~ray/notes/regex/
;Read above if you lost

;config;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SetTitleMatchMode "RegEx"
#F1::ReloadWithMessage() ; Win+F1 will reload script
#F2::Edit() ; Win+F2 will open this file
#F3::GetCurrentWindowInfoToClipboard() ; Win+F3 send current window info to clipboard
#Del::!F4 ; Win+Delete will send Alt+F4 to current window

#e::cycleLauncher('File Explorer', 'C:\Windows\explorer.exe')
#w::cycleLauncher('Microsoft​ Edge', 'C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe')
#a::cycleLauncher('Google AI Studio', '"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe --new-window --app=https://aistudio.google.com/"')
#g::cycleLauncher('ChatGPT', '"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe --new-window --app=https://chatgpt.com"')

;functions;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cycleLauncher(title, command) { ; Cycle windows focus, execute a command if no window is found. 
    WinList := WinGetList(title) ; List all window contain title
    focusedWindow := WinGetID("A") ; Get the active window ID

    if (WinList.Length = 0) { ; If no window found, Launch exe as non-admin
        Run("runas /trustlevel:0x20000 " command) 
    } else if (WinList[1] = focusedWindow) { ; If window found, and alredy focused on one of them
        WinActivate("ahk_id " WinList[-1]) ; Focus to the last, to cycle focus.
    } else {
        WinActivate("ahk_id " WinList[1]) ; If focus is on other app, focus
    } 
}


GetCurrentWindowInfoToClipboard() {
    focusedWindow := WinGetID("A") ; Get the active window ID
    title := WinGetTitle("ahk_id " focusedWindow) ; Get the title
    exeName := WinGetProcessPath("ahk_id " focusedWindow) ; Get the process name
    clipboardText := "'" title "', '" exeName "'" ; Formatting for cycleLauncher()
    A_Clipboard := clipboardText ; Send to the clipboard
    ToolTip(clipboardText) ; display a tooltip to confirm
    SetTimer(() => ToolTip(), -3000) ; Remove tooltip after 1 second
}

ReloadWithMessage(){
    ToolTip("Reload Focus Launcher") ; display a tooltip to confirm
    SetTimer(() => ToolTip(), -400) ; Remove tooltip after 0.4 second
    Sleep 500
    Reload
}
