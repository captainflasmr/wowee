; #HotIf !WinActive("ahk_class Emacs")

;; -----------
;; M- bindings
;; -----------
!+'::set_mark_command()
!'::set_mark_command()

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