#Warn All, Off
InstallKeybdHook
InstallMouseHook
#UseHook
A_MaxHotkeysPerInterval := 100

SetKeyDelay 0
SendMode "Event"
CoordMode "Mouse", "Screen"

;; -----------------
;; Utility Functions
;; -----------------

;; a wrapper function of "Send"
eSend(str) {
        Send(str)
}
