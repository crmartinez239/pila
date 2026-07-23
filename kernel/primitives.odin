package kernel

import "core:fmt"

@(private)
DROP :: proc(data_stack: ^Data_Stack) -> NativeProcResult {
    if (len(data_stack^)) < 1 do return NativeProcResult.StackUnderflow
    pop(data_stack)
    return NativeProcResult.Success
}

@(private)
DUP :: proc(data_stack: ^Data_Stack) -> NativeProcResult {
    if (len(data_stack^)) < 1 do return NativeProcResult.StackUnderflow
    u := data_stack^[0]
    append(data_stack, u)
    return NativeProcResult.Success
}

@(private)
SWAP :: proc(data_stack: ^Data_Stack) -> NativeProcResult {
    if (len(data_stack^)) < 2 do return NativeProcResult.StackUnderflow
    last := len(data_stack^) - 1
    u1 := data_stack^[last]
    u2 := data_stack^[last -1]
    data_stack^[last] = u2
    data_stack^[last - 1] = u1
    return NativeProcResult.Success
}