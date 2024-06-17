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

next_lines() {
    command_motion("{Down}", 3)
}

previous_line() {
    command_motion("{Up}", 1)
}

previous_lines() {
    command_motion("{Up}", 3)
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

beginning_of_buffer() {
    command_motion("^{Home}", 9)
}

end_of_buffer() {
    command_motion("^{End}", 0)
}

;; --------
;; deleting
;; --------

delete_char() {
    command_simple("{Del}", 1, 1)
}

;; ------
;; region
;; ------

kill_ring_save() {
    command_simple("^c", 1, 1)
}

yank() {
    command_simple("^v", 1, 1)
}

;; -------------
;; edit commands
;; -------------

undo_only() {
    command_simple("^z", 1, 1)
}

;; -----
;; files
;; -----

save_buffer() {
    command_simple("^s", 0, 0)
}
