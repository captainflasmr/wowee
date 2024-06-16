;; This script provides: command skeletons

#Include commands_util.ahk

;; --------
;; motion
;; --------

forward_char() {
    command_motion("{Right}", 1)
}

backward_char() {
    command_motion("{Left}", 1)
}

forward_word() {
    command_motion("^{Right}", 1)
}

backward_word() {
    command_motion("^{Left}", 1)
}

next_line() {
    command_motion("{Down}", 1)
}

previous_line() {
    command_motion("{Up}", 1)
}

;; --------------
;; jumping around
;; --------------

scroll_down() {
    command_motion("{PgDn}", 1)
}

scroll_up() {
    command_motion("{PgUp}", 1)
}

move_beginning_of_line() {
    command_motion("{Home}", 0)
}

move_end_of_line() {
    command_motion("{End}", 0)
}

;; --------
;; deleting
;; --------

delete_char() {
    command_simple("{Del}", 1, 1)
}
