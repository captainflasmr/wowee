;; This script provides: command skeletons

;; <function>

;; command_simple(str, [causechange 0], [repeatable 0])
;; ... send string as a command  (when causechange is t, call after_change_hook)

;; command_motion(str, [repeatable 0])
;; ... send string as a command that can expand the region

;; -----------------
;; command skeletons
;; -----------------

;; command_str(str, moves = 0, changes = 0, repeatable = 0, prestr = "", poststr = "")
;; { Global
;;     Local sendstr = make_str(str, (arg && repeatable) ? arg 1)
;;     If (moves && mark)
;;         sendstr = {shift down}%sendstr%{shift up}
;;     run_hooks("pre_command_hook")
;;     send(sendstr)
;;     run_hooks("post_command_hook")
;; }

;; command_function(fnname, changes = 0, repeatable = 0)
;; { Global
;;     run_hooks("pre_command_hook")
;;     Loop, % (arg && repeatable) ? arg : 1
;;         funcall(fnname)
;;     If changes
;;         run_hooks("after_change_hook")
;;     run_hooks("post_command_hook")
;; }

;; command that simply sends a key or calls a function
;; WILL BE OBSOLETE
command_simple(str, changes := false, repeatable := 1) {
    global
    run_hooks("pre_command_hook")

    if IsFunc(str) {
        loop (repeatable ? repeatable : 1) {
            Func(str).Call()
        }
    } else {
        loop (repeatable ? repeatable : 1) {
            Send(str)
        }
    }

    if changes {
        run_hooks("after_change_hook")
    }
    run_hooks("post_command_hook")
}

global mark

;; a command that moves cursor position
;; WILL BE OBSOLETE
command_motion(str, repeatable := 1) {
    global
    run_hooks("pre_command_hook")
    if mark {
        str := "{Shift down}" str "{Shift up}"
    }
    loop (repeatable ? repeatable : 1) {
        Send(str)
    }
    run_hooks("post_command_hook")
}

;; WILL BE OBSOLETE
command_abc(a, b, c, change := false, repeatable := 1) {
    global
    run_hooks("pre_command_hook")
    Send(a)
    loop (repeatable ? repeatable : 1) {
        Send(b)
    }
    Send(c)
    if change {
        run_hooks("after_change_hook")
    }
    run_hooks("post_command_hook")
}

;; command that inserts a balanced expression
command_pair(str, repeatable := 1) {
    global
    run_hooks("pre_command_hook")
    if mark {
        Send("^x")
    }
    loop (repeatable ? repeatable : 1) {
        Send(str)
    }
    if mark {
        Send("^v")
    }
    run_hooks("after_change_hook")
    run_hooks("post_command_hook")
}

;; command that selects something
command_mark(str) {
    run_hooks("pre_command_hook")
    Send(str)
    set_mark()
    run_hooks("post_command_hook")
}
