package kernel

import "core:fmt"

DROP :: proc(data_stack: ^[dynamic]u64) -> NativeProcResult {
    if (len(data_stack^)) < 1 do return NativeProcResult.StackUnderflow
    pop(data_stack)
    return NativeProcResult.Success
}

DUP :: proc(data_stack: ^[dynamic]u64) -> NativeProcResult {
    if (len(data_stack^)) < 1 do return NativeProcResult.StackUnderflow
    u := data_stack^[0]
    append(data_stack, u)
    return NativeProcResult.Success
}

SWAP :: proc(data_stack: ^[dynamic]u64) -> NativeProcResult {
    if (len(data_stack^)) < 2 do return NativeProcResult.StackUnderflow
    last := len(data_stack^) - 1
    u1 := data_stack^[last]
    u2 := data_stack^[last -1]
    data_stack^[last] = u2
    data_stack^[last - 1] = u1
    return NativeProcResult.Success
}