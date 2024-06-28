;; This script provides: default keybinds

; #HotIf !WinActive("ahk_class Emacs")

;; -----------
;; M- bindings
;; -----------

!b::backward_word()
!f::forward_word()
!v::scroll_up()
!+w::kill_ring_save()
!w::kill_ring_save()
!bs::backward_kill_word()
!<::beginning_of_buffer()
!>::end_of_buffer()

;; -----------
;; C- bindings
;; -----------
^b::backward_char()
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
^r::isearch("^f", "{Enter}")
^s::isearch("^f", "{Enter}")
^+space::set_mark_command()
^space::set_mark_command()

;; -----------
;; C- disables
;; -----------
^+c::return

;; -----------
;; C-x bindings
;; -----------
^x:: {
        hook := InputHook("L1", "{s}{h}")
        hook.Start()
        hook.Wait()
        if (hook.EndKey == "s") {
                save_buffer()
        }
        if (hook.EndKey == "h") {
                mark_whole_buffer()
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
