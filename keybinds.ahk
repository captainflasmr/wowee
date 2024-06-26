;; This script provides: default keybinds

RAlt::Control

#HotIf !WinActive("ahk_class Emacs")

;; -----------
;; M- bindings
;; -----------

!b::backward_word()
!f::forward_word()
!v::scroll_up()
!+w::kill_ring_save()
!w::kill_ring_save()
!+'::set_mark_command()
!'::set_mark_command()
!bs::backward_kill_word()

;; -----------
;; M- ergo bindings
;; -----------
!+h::backward_char()
!+j::next_line()
!+k::previous_line()
!+l::forward_char()
!h::backward_char()
!j::next_line()
!k::previous_line()
!l::forward_char()
![::yank()
!n::next_lines()
!m::previous_lines()

;; -----------
;; C- bindings
;; -----------
; ^b::backward_char()
^n::next_line()
^p::previous_line()
^f::forward_char()
^e::move_end_of_line()
^+e::move_end_of_line()
^a::move_beginning_of_line()
^+a::move_beginning_of_line()
^d::delete_char()
^v::scroll_down()
^y::yank()
^/::undo_only()
^k::kill_line()
^+g::quit_g()
^g::quit_g()
^i::indent_line()
^+i::indent_line()
^l::recenter_line()
^r::isearch_backward()
^s::isearch_forward()
^+space::set_mark_command()
^space::set_mark_command()

;; -----------
;; C- disables
;; -----------
^+c::return


;; -----------
;; M-s bindings
;; -----------
!s:: {
        hook := InputHook("L1", "{[}{]}{,}")
        hook.Start()
        hook.Wait()
        if (hook.EndKey == "[") {
                beginning_of_buffer()
        }
        if (hook.EndKey == "]") {
                end_of_buffer()
        }
        if (hook.EndKey == ",") {
                select_line()
        }
        hook := ""
}

;; -----------
;; C-x bindings
;; -----------
^x:: {
        hook := InputHook("L1", "{s}")
        hook.Start()
        hook.Wait()
        if (hook.EndKey == "s") {
                save_buffer()
        }
        hook := ""
}

;; -----------
;; M-g bindings
;; -----------
!g:: {
        hook := InputHook("L1", "{g}")
        hook.Start()
        hook.Wait()
        if (hook.EndKey == "g") {
                goto_line()
        }
        hook := ""
}


#HotIf
