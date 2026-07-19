package kernel

import "core:fmt"

CodeField :: proc()

Primitive :: struct {
    name: string,
    cfa: CodeField,
}

Word :: struct {
    link: ^Word, // LFA
    name: string, // NFA
    cfa: CodeField,
}

init_dictionary :: proc() -> ^Word {

    primitives := []Primitive {
        {"DUP", DUP},
        {"DROP", DROP},
        {"SWAP", SWAP},
    }

    prev: ^Word = nil
    
    for i in 0..<len(primitives) {
        w := Word {
            prev,
            primitives[i].name,
            primitives[i].cfa,
        }
        prev = &w
    }
    
    // return the latest word in the list
    return prev
}