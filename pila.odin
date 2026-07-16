package pila

import "core:os"

main :: proc() {
    if len(os.args) == 1 {
        usage()
        os.exit(1)
    }
}