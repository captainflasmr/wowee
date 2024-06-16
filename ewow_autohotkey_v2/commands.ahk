;; This script provides: command skeletons

#Include commands_util.ahk

kmacro_tt := alloc_tt()

kill_ring_size := 100

;; ---------
;; utilities
;; ---------

safe_cut() {
    Clipboard := ""
    Send("^x")
    ClipWait(0.5) ; confirm that the Clipboard is updated
}

;; ---------
;; kill_ring
;; ---------

kill_ring_pointer := 0

kill_ring_push() {
    global
    kill_ring_pointer := Mod(kill_ring_pointer + 1, kill_ring_size)
    kill_ring[kill_ring_pointer] := Clipboard
}

kill_ring_pop() {
    global
    kill_ring_pointer := Mod(kill_ring_pointer + kill_ring_size - 1, kill_ring_size)
    Clipboard := kill_ring[kill_ring_pointer]
}

kill_ring_restore() {
    global
    Clipboard := kill_ring[kill_ring_pointer]
}

;; --------------
;; alttab command
;; --------------

alt_pressed := 0

alttab_next() {
    global
    alt_pressed := 1
    command_simple("{Alt down}{Tab}", 0, 1)
}

alttab_end() {
    global
    alt_pressed := 0
    command_simple("{Alt up}", 0, 0)
}

;; -----------
;; send itself
;; -----------

self_insert_command() {
    command_simple(A_ThisHotkey, 1, 1)
}

self_send_command() {
    tmp := "{" A_ThisHotkey "}"
    command_simple(tmp, 0, 1)
}

mouse_event_command() {
    MouseGetPos(&x, &y)

    if RegExMatch(A_ThisHotkey, "(\W*)(\w*)( up)?", res) {
        if res2 == "LButton"
            key := "L"
        else if res2 == "RButton"
            key := "R"
        else if res2 == "MButton"
            key := "M"
        else if res2 == "XButton1"
            key := "X1"
        else if res2 == "XButton2"
            key := "X2"
        else
            return

        updn := res3 ? "U" : "D"
        key := res1 "{Click, " key ", " x ", " y ", 1, " updn "}"
        command_simple(key, 0, 1)
    }
}

;; digit argument
digit_argument() {
    global
    run_hooks("pre_command_hook")
    tmp := SubStr(A_ThisHotkey, 2)
    set_digit_argument(arg * 10 + tmp)
    run_hooks("post_command_hook")
}

;; ------
;; system
;; ------

ignore() {
    run_hooks("pre_command_hook")
    run_hooks("post_command_hook")
}

set_mark_command() {
    command_simple("set_mark", 0, 0)
}

set_cx_command() {
    global
    run_hooks("pre_command_hook")
    set_digit_argument(arg)
    set_cx()
    run_hooks("post_command_hook")
}

keyboard_quit() {
    global
    run_hooks("pre_command_hook")
    if mark
        reset_mark()
    else
        Send("{Escape}")
    run_hooks("post_command_hook")
}

repeat() {
    global
    command_simple(last_command, 0, 1)
}

;; ------
;; kmacro
;; ------

kmacro_recoding := 0
kmacro_count := 0

kmacro_start() {
    global
    kmacro_recoding := 1
    kmacro_count := 0
    ToolTip("REC", , , kmacro_tt)
}

kmacro_after_send_function() {
    global
    if kmacro_recoding {
        kmacro_count++
        kmacro[kmacro_count] := last_command
        ToolTip(last_command, , , kmacro_tt)
    }
}

kmacro_end() {
    global
    kmacro_recoding := 0
    ToolTip("", , , kmacro_tt)
}

kmacro_call() {
    global
    MouseGetPos(&x, &y)
    Loop kmacro_count {
        varname := kmacro[A_Index]
        Send(varname)
    }
    Click x, y, 0
}

add_hook("after_send_hook", "kmacro_after_send_function")

kmacro_end_macro() {
    command_simple("kmacro_end", 0, 0)
}

kmacro_start_macro() {
    command_simple("kmacro_start", 0, 0)
}

kmacro_call_macro() {
    command_simple("kmacro_call", 0, 1)
}

kmacro_end_or_call_macro() {
    global
    if kmacro_recoding
        kmacro_end_macro()
    else
        kmacro_call_macro()
}

kmacro_end_and_call_macro() {
    global
    run_hooks("pre_command_hook")
    if kmacro_recoding
        kmacro_end()
    Loop arg ? arg : 1
        kmacro_call()
    run_hooks("post_command_hook")
}

;; -----
;; files
;; -----

save_buffer() {
    command_simple("^s", 0, 0)
}

write_file() {
    command_simple("{Alt down}fa{Alt up}", 0, 0)
}

find_file() {
    command_simple("^o", 0, 0)
}

dired() {
    command_simple("#e", 0, 0)
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

split_window() {
    command_simple("^t", 0, 1)
}

next_window() {
    command_simple("^{Tab}", 0, 1)
}

previous_window() {
    command_simple("^+{Tab}", 0, 1)
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

scroll_left() {
    command_motion("!{PgUp}", 1)
}

scroll_right() {
    command_motion("!{PgDn}", 1)
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

goto_line() {
    run_hooks("pre_command_hook")
    InputBox(&line, "Goto:")
    if IsNumber(line) {
        line--
        reset_mark()
        Send("^{Home}")
        Loop line
            Send("{Down}")
    }
    run_hooks("post_command_hook")
}

;; ------
;; region
;; ------

mark_word() {
    command_mark("^{Right}{Shift down}^{Left}{Shift up}")
}

mark_whole_line() {
    command_mark("{Home}{Shift down}{End}{Shift up}")
}

mark_whole_buffer() {
    command_mark("^a")
}

kill_ring_save() {
    run_hooks("pre_command_hook")
    Send("^c")
    reset_mark()
    kill_ring_push()
    run_hooks("post_command_hook")
}

kill_region() {
    command_simple("^x", 1, 0)
    kill_ring_push()
}

yank() {
    command_simple("^v", 1, 1)
}

yank_pop() {
    run_hooks("pre_command_hook")
    Send("^z")
    Loop arg ? arg : 1
        kill_ring_pop()
    Send("^v")
    run_hooks("after_change_hook")
    run_hooks("post_command_hook")
}

delete_char() {
    command_simple("{Del}", 1, 1)
}

delete_backward_char() {
    command_simple("{BS}", 1, 1)
}

kill_word() {
    command_abc("", "{Shift down}^{Right}{Shift up}", "^x", 1)
    kill_ring_push()
}

backward_kill_word() {
    command_abc("", "{Shift down}^{Left}{Shift up}", "^x", 1)
    kill_ring_push()
}

kill_line() {
    command_simple("{Shift down}{End}{Shift up}^x", 1, 0)
    kill_ring_push()
}

kill_whole_line() {
    command_simple("{Home}{Shift down}{End}{Right}{Shift up}^x", 1, 0)
    kill_ring_push()
}

;; ------------------
;; newline and indent
;; ------------------

newline() {
    command_simple("{Enter}", 1, 1)
}

open_line() {
    command_simple("{Enter}{Left}", 1, 1)
}

indent_for_tab_command() {
    command_simple("{Tab}", 1, 1)
}

delete_indentation() {
    command_simple("{Home}{BS}", 1, 1)
}

;; -------------
;; edit commands
;; -------------

undo_only() {
    command_simple("^z", 1, 1)
}

redo() {
    command_simple("^y", 1, 1)
}

transpose_chars() {
    command_abc("{Left}{Shift down}{Right}{Shift up}^x", "{Right}", "^v", 1)
    kill_ring_restore()
}

transpose_words() {
    command_abc("{Left}^{Right}{Shift down}^{Left}{Shift up}^x", "^{Right}", "^v", 1)
    kill_ring_restore()
}

transpose_lines() {
    command_abc("{Up}{Home}{Shift down}{Down}{Shift up}^x", "{Down}", "^v", 1)
    kill_ring_restore()
}

query_replace() {
    command_simple("^h", 0, 0)
}

search_forward() {
    command_simple("^f", 0, 0)
}

overwrite_mode() {
    command_simple("{Insert}", 0, 0)
}

;; ---------------
;; case conversion
;; ---------------

upcase_region() {
    run_hooks("pre_command_hook")
    safe_cut()
    Clipboard := StrUpper(Clipboard)
    Send("^v")
    run_hooks("after_change_hook")
    run_hooks("post_command_hook")
}

downcase_region() {
    run_hooks("pre_command_hook")
    safe_cut()
    Clipboard := StrLower(Clipboard)
    Send("^v")
    run_hooks("after_change_hook")
    run_hooks("post_command_hook")
}

upcase_word() {
    run_hooks("pre_command_hook")
    Send("^{Right}{Shift down}^{Left}{Shift up}")
    safe_cut()
    Clipboard := StrUpper(Clipboard)
    Send("^v")
    run_hooks("after_change_hook")
    run_hooks("post_command_hook")
}

downcase_word() {
    run_hooks("pre_command_hook")
    Send("^{Right}{Shift down}^{Left}{Shift up}")
    safe_cut()
    Clipboard := StrLower(Clipboard)
    Send("^v")
    run_hooks("after_change_hook")
    run_hooks("post_command_hook")
}

capitalize_word() {
    run_hooks("pre_command_hook")
    Send("{Shift down}^{Right}{Shift up}")
    safe_cut()
    Clipboard := StrUpper(Clipboard)
    Send("^v")
    run_hooks("after_change_hook")
    run_hooks("post_command_hook")
}

;; ---------------
;; inserting pairs
;; ---------------

insert_parentheses() {
    command_pair("(){Left}")
}

insert_comment() {
    command_pair("/*  */{Left}{Left}{Left}")
}

indent_new_comment_line() {
    command_simple("{Enter} *{Space}", 1, 1)
}

;; ------
;; others
;; ------

shell() {
    run_hooks("pre_command_hook")
    Run("cmd.exe")
    run_hooks("after_display_transition_hook")
    run_hooks("post_command_hook")
}

shell_command() {
    command_simple("#r", 0, 0)
}

facemenu() {
    command_simple("^d", 0, 0)
}

help() {
    command_simple("{F1}", 0, 0)
}
