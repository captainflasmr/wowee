;; This script provides: default keybinds

;; -----------
;; M- bindings
;; -----------

!b::backward_word()
!f::forward_word()
!v::scroll_up()
!h::backward_char()
!j::next_line()
!k::previous_line()
!l::forward_char()
!w::kill_ring_save()
!n::next_lines()
!m::previous_lines()
![::beginning_of_buffer()
!]::end_of_buffer()

;; -----------
;; C- bindings
;; -----------
^b::backward_char()
^n::next_line()
^p::previous_line()
^f::forward_char()
^e::move_end_of_line()
^a::move_beginning_of_line()
^d::delete_char()
^v::scroll_down()
^y::yank()
^/::undo_only()
^s::save_buffer()
