command_simple(str, changes := false, repeatable := 1) {
        loop (repeatable ? repeatable : 1) {
            eSend(str)
        }
}

command_motion(str, repeatable := 1) {
    loop (repeatable ? repeatable : 1) {
        eSend(str)
    }
}
