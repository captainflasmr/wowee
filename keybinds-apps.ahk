;; ----------------------------------------
;; Application Specific
;; ----------------------------------------

;; -------------
;; Visual Studio
;; -------------
;; Shortcut rebindings:
;;
;; Control+p Control+s : Text Editor : Incremental Search
;; Control+p Control+r : Text Editor : Incremental Search Reverse
;; Control+p Control+l : Text Editor : Scroll Recenter
;; Control+p Control+f : Text Editor : Format selection
;; Control+p Control+/ : Text Editor : Toggle Comment Line
;; Control+p Control+3 : Text Editor : New Vertical Tab Group

#HotIf WinActive("ahk_exe devenv.exe")
^r::isearch("^p^r", "{Shift down}{F3}{Shift up}")
^s::isearch("^p^s", "{F3}")
^l::recenter_line()
^i::indent_line()
^+i::indent_line()
!;::comment_line("^p^/")
!+;::comment_line("^p^/")
^b::return
;; -----------
;; C-x bindings
;; -----------
; ^x:: {
;         hook := InputHook("L1", "{3}")
;         hook.Start()
;         hook.Wait()
;         if (hook.EndKey == "3") {
;                 split_window_vertically()
;         }
;         hook := ""
; }

;; -------------
;; VS Code
;; -------------
;; Shortcut rebindings:
;;
;; Control+p Control+/ : Text Editor : Toggle Line Comment

#HotIf WinActive("ahk_exe Code.exe")
^r::isearch("^f", "{Shift down}{Enter}{Shift up}")
^s::isearch("^f", "{Enter}")
!;::comment_line("^p^/")
!+;::comment_line("^p^/")
^b::return

#HotIf
