;; This script provides: command skeletons

#Include commands_util.ahk

global selecting := false
global searching := false

;; ------
;; system
;; ------

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

;; -----
;; files
;; -----

save_buffer() {
    command_simple("^s", 0, 0)
}

;; ---------------
;; windows, frames
;; ---------------

kill_frame() {
    command_simple("!{F4}", 0, 0)
}

delete_window() {
    command_simple("^{F4}", 0, 1)
}

split_window_vertically() {
    command_simple("^p^3", 0, 1)
}

maximize_window() {
    command_simple("#{Up}", 0, 1)
}

next_window() {
    command_simple("!{Tab}", 0, 1)
}

previous_window() {
    command_simple("!+{Tab}", 0, 1)
}

suspend_frame() {
    command_simple("#{Down}", 0, 0)
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

goto_line() {
        command_simple("^g", 0, 1)
}

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

;; ------
;; region
;; ------

select_line() {
    command_simple("{Home}{Shift down}{End}{Shift up}", 1, 0)
}

backward_kill_word() {
    command_simple("^{BS}", 1, 1)
}

mark_whole_buffer() {
        command_simple("^a", 1, 1)
}

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

;; --------
;; deleting
;; --------

delete_char() {
    command_simple("{Del}", 1, 1)
}

;; ------------------
;; newline and indent
;; ------------------

recenter_line() {
    command_simple("^p^l", 1, 1)
}

indent_line() {
    select_line()
    command_simple("^p^f", 1, 1)
    quit_g()
}

;; -------------
;; edit commands
;; -------------

isearch(start_cmd, next_cmd) {
        global searching
        if (!searching) {
                searching := true
                command_simple(start_cmd, 1, 1)
        }
        else {
                command_simple(next_cmd, 1, 1)
        }
}

undo_only() {
    command_simple("^z", 1, 1)
}

;; ---------------
;; inserting pairs
;; ---------------
comment_line(cmd) {
        command_simple(cmd, 1, 1)
}
