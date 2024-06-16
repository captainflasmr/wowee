;; This script provides: fundamental functions, environment

;; <utility functions>

;; - foreach(list, fnname)               ... apply function to all elements in a list
;; - add_to_list(listname, element)      ... add an element to a list
;; - remove_from_list(listname, element) ... remove an element from a list

;; - make_str(str, n) ... repeat str n-times

;; - funcall(fnname) ... call function with no arguments

;; <functions>

;; - ignored_frame() ... decide if EWOW should be quiet
;; => configure with "ignored_frames" variable

;; - alloc_tt() ... get an id for ToolTip

;; <commands>

;; - send(str) ... a wrapper function of "Send", either call STR as a function or send STR
;; => ALWAYS USE THIS FUNCTION TO INTERACT WITH WINDOWS, SO THAT IT'S RECORDED IN MACROS

;; - read_char() ... steal one event from send() and return it

;; <hooks>

;; - pre_command_hook  ... all commands must run at the very beginning
;; - post_command_hook ... all commands must run at the very end
;; - after_change_hook ... all commands must run just after changes
;; => use "run_hooks" to run

;; - before_send_hook              ... automatically run before send()
;; - after_send_hook               ... automatically run after send()
;; - after_display_transition_hook ... automatically run after display transitions
;; => run automatically

;; - add_hook(hookname, fnname)    ... add a function to a hook
;; - remove_hook(hookname, fnname) ... remove a function from a hook
;; - run_hooks(hookname)           ... run all functions in a hook

;; <variables>

;; - last_command   ... the last event (being) sent with send()
;; => you may assume that this variable is already updated in before_send_hook

;; <settings>

;; - ignored_frames ... list of window-classes in which EWOW should be quiet

;; --------------
;; (AHK Tutorial)
;; --------------

;; funname()
;; { Global                     <- use global variables
;;     Local foo                <- but keep variable "foo" local
;;     foo = foo                <- set foo to a string literal "foo"
;;     foo = %foo%              <- set foo to a foo's value
;;     foo := foo               <- (equivalent)
;;     foo = %foo%bar           <- concatenate foo's value and a string literal "bar"
;;     foo .= bar               <- (equivalent)
;;     MsgBox foo is %foo%      <- call command MsgBox with "foo is %foo%"
;;     MsgBox % "foo is " . foo <- equivalent to the previous line
;;     message("foo is " . foo) <- call function message with "foo is %foo%"
;;     message(foo is %foo%)     <- (NO GOOD)
;; }

;; ------------------
;; AHK configurations
;; ------------------

#Warn All, Off
InstallKeybdHook
InstallMouseHook
#UseHook
A_MaxHotkeysPerInterval := 100

; SetBatchLines -1
SetKeyDelay 0
SendMode "Event"
CoordMode "Mouse", "Screen"

;; -----------------
;; Utility Functions
;; -----------------

foreach(list, fnname) {
    global
    for field in StrSplit(list, ",") {
        Func(fnname).Call(field)
    }
}

add_to_list(listname, element) {
    global
    list := %listname%
    elements := StrSplit(list, ",")
    for _, e in elements {
        if (e == element) {
            return
        }
    }
    if (list != "") {
        %listname% := list "," element
    } else {
        %listname% := element
    }
}

remove_from_list(listname, element) {
    global
    list := %listname%
    regex := ",?" element
    %listname% := RegExReplace(list, regex, "")
}

funcall(fnname) {
    global
    if IsFunc(fnname) {
        Func(fnname).Call()
    }
}

make_str(str, n) {
    out := ""
    loop n {
        out .= str
    }
    return out
}

;; -----
;; Hooks
;; -----

pre_command_hook := ""
post_command_hook := ""
after_change_hook := ""
;; => call manually

before_send_hook := ""
after_send_hook := ""
;; => called by send()

after_display_transition_hook := ""
;; => called on WinEventHook

run_hooks(hookname) {
    global
    foreach(%hookname%, "funcall")
}

remove_hook(hookname, fnname) {
    remove_from_list(hookname, fnname)
}

add_hook(hookname, fnname) {
    add_to_list(hookname, fnname)
}

;; ----
;; Send
;; ----

read_char_waiting := 0
last_command := ""

;; a wrapper function of "Send"
send(str) {
    global
    last_command := str
    run_hooks("before_send_hook")
    if (read_char_waiting) {
        read_char_waiting := 0
    } else if IsFunc(last_command) {
        Func(last_command).Call()
    } else {
        Send(last_command)
    }
    run_hooks("after_send_hook")
}

read_char() {
    global
    read_char_waiting := 1
    while (read_char_waiting) {
    }
    return last_command
}

;; -------------------------
;; Detect Display Transition
;; -------------------------

;; taken from
;; https://sites.google.com/site/agkh6mze/howto/winevent

dt_callback(a, b, c, d, e, f, g) {
    run_hooks("after_display_transition_hook")
}

dt_event_proc := CallbackCreate(dt_callback)

DllCall("SetWinEventHook"
    , "UInt", 0x00000003, "UInt", 0x00000003, "UInt", 0
    , "UInt", dt_event_proc, "UInt", 0, "UInt", 0, "UInt", 0x0003, "UInt")

;; --------------
;; Ignored Frames
;; --------------

ignored_frames := "ConsoleWindowClass,cygwin/x X rl-xterm-XTerm-0,mintty,MEADOW,Vim,Emacs,XEmacs,SunAwtFrame,Xming X,VMPlayerFrame,VirtualConsoleClass"

;; decide if ewow should be quiet
ignored_frame()
{ Global
    Local class
    WinGetClass classx A
    list := %ignored_frames%
    elements := StrSplit(list, ",")
    for _, e in elements {
        if (e == element) {
            return 1
        }
    }
    Return 0
}

;; -----------------
;; Manage ToolTip ID
;; -----------------

;; alloc_tt() allocates an id for the new ToolTip
;; and returns it

tt_count := 0

alloc_tt() {
    global
    tt_count++
    return tt_count
}
