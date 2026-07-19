package kernel

import "core:fmt"

DUP :: proc(data_stack: ^[dynamic]u64) {
    fmt.println("DUP command successful")
}

DROP :: proc(data_stack: ^[dynamic]u64) {
    fmt.println("DROP command successful")
}

SWAP :: proc(data_stack: ^[dynamic]u64) {
    fmt.println("SWAP command successful")
}