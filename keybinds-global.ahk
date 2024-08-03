;; ---------------
;; Local Functions
;; ---------------

next_workspace() {
        Send("^#{Right}")
        Click
}

prev_workspace() {
        Send("^#{Left}")
        Click
}

quit_window() {
        Send("!{F4}")
}

open_emacs() {
        Run('cmd.exe /c "C:\Users\jimbo\source\emacs-30.0\start.bat"', , "Hide")
}

open_browser() {
        Run('cmd.exe /c "C:\Program Files\Mozilla Firefox\firefox.exe"', , "Hide")
}

;; -------------------
;; Workspace Switching
;; -------------------

#i::next_workspace()
#u::prev_workspace()

;; ---------------
;; Window commands
;; ---------------
#q::quit_window()

;; --------------------
;; Startup Applications
;; --------------------
#m::open_emacs()
#n::open_browser()