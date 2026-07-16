package pila

import "core:fmt"

MESSAGE ::
`pila virtual machine
Usage:`

usage :: proc() {
    fmt.eprintln(MESSAGE)
}