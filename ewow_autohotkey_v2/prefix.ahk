;; This script provides: mark, prefix C-x, prefix argument

;; <variables>

;; - cx   ... true if C-x is prefixed
;; - mark ... true if mark is active
;; - arg  ... digit argument as an integer

;; <setters>

;; - set_cx()/reset_cx()
;; - set_mark()/reset_mark()
;; - set_digit_argument(n)

prefix_tt := alloc_tt()
mark_tt := alloc_tt()

;; --------------
;; set/reset mark
;; --------------

global mark := 0

set_mark() {
    global mark, mark_tt
    mark := 1
    ToolTip(mark, 45, 0, mark_tt)
}

reset_mark() {
    global mark, mark_tt
    mark := 0
    ToolTip("", , , mark_tt)
}

add_hook("after_change_hook", "reset_mark")
add_hook("after_display_transition_hook", "reset_mark")

;; ----------
;; prefix C-x
;; ----------

global cx := 0

set_cx() {
    global cx, prefix_tt
    cx := 1
    ToolTip("C-x -", 1, 0, prefix_tt)
}

reset_cx() {
    global cx, prefix_tt
    cx := 0
    ToolTip("", , , prefix_tt)
}

add_hook("pre_command_hook", "reset_cx")

;; --------------
;; digit argument
;; --------------

global arg := 0
global arg_internal := 0

set_digit_argument(n) {
    global arg_internal, prefix_tt
    arg_internal := n
    ToolTip(arg_internal, 1, 0, prefix_tt)
}

;; retrieve arg from arg_internal
get_argument() {
    global arg, arg_internal, prefix_tt
    arg := arg_internal
    arg_internal := 0
    ToolTip("", , , prefix_tt)
}

add_hook("pre_command_hook", "get_argument")
