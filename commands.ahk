;; This script provides: command skeletons

#Include commands_util.ahk

global selecting := false
global searching := false

isearch_backward() {
        global searching
        if (searching) {
                command_simple("{Shift down}{F3}{Shift up}", 1, 1)
        }
        else {
                searching := true
                command_simple("^p^r", 1, 1)
        }
}

isearch_forward() {
        global searching
        if (searching) {
                command_simple("{F3}", 1, 1)
        }
        else {
                searching := true
                command_simple("^p^s", 1, 1)
        }
}

recenter_line() {
    command_simple("^p^l", 1, 1)
}

indent_line() {
    select_line()
    command_simple("^p^f", 1, 1)
    quit_g()
}

backward_kill_word() {
    command_simple("^{BS}", 1, 1)
}

select_line() {
    command_simple("{Home}{Shift down}{End}{Shift up}", 1, 0)
}

goto_line() {
        command_simple("^g", 0, 1)
}

set_mark_command() {
        global selecting
        if (selecting) {
                selecting := false
                command_simple("{Shift up}", 0, 1)
        }
        else {
                selecting := true
                command_simple("{Shift down}", 0, 1)
        }
}

quit() {
        global selecting
        selecting := false
        command_simple("{Shift up}", 0, 1)
}

quit_g() {
        global selecting, searching
        selecting := false
        searching := false
        command_simple("{Shift up}{Escape}", 0, 1)
}

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
    command_motion("{Down}", 6)
}

previous_line() {
    command_motion("{Up}", 1)
}

previous_lines() {
    command_motion("{Up}", 6)
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
        quit()
        command_simple("^c{Escape}", 1, 1)
}

kill_line() {
    command_simple("{Shift down}{End}{Shift up}^x", 1, 0)
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

;; ------
;; system
;; ------
