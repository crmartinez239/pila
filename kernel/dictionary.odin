package kernel

import "core:fmt"

NativeProc :: proc(data_stack: ^[dynamic]u64)

Primitive :: struct {
    name: string,
    cfa: NativeProc,
}

Word :: struct {
    link: ^Word, // LFA
    name: string, // NFA
    cfa: NativeProc,
}

init_dictionary :: proc() -> ^Word {

    primitives := []Primitive {
        {"DUP", DUP},
        {"DROP", DROP},
        {"SWAP", SWAP},
    }

    prev: ^Word = nil
    
    for i in 0..<len(primitives) {
        w := new(Word)
        w^ = Word {
            prev,
            primitives[i].name,
            primitives[i].cfa,
        }
        prev = w
    }    
    // return the latest word in the list
    return prev
}

find_word :: proc(name: string, latest: ^Word) -> ^Word {
    current := latest.link
    for current != nil {
        if current.name == name do return current
        current = current.link
    }
    return nil
}