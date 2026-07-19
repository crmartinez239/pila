package kernel

import "core:fmt"

CodeField :: proc(data_stack: ^[dynamic]u64)

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
    if latest.name == name do return latest
    prev := latest.link
    for prev != nil {
        if prev.name == name {
            return prev
        } else {
            prev = prev.link
        }
    }
    return nil
}