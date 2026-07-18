package pila

import "core:fmt"

MESSAGE ::
`pila virtual machine
Usage:
    pila [flags] <filename>
Flags:
    -v  Prints pila verison to console`

usage :: proc() {
    fmt.eprintln(MESSAGE)
}