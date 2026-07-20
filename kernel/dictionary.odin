package kernel

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

    primitives := [3]Primitive {
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

free_dictionary :: proc(latest_word: ^Word) {
    current := latest_word
    for current != nil {
        next := current.link
        free(current)
        current = next
    }
}

find_word :: proc(name: string, latest: ^Word) -> ^Word {
    current := latest.link
    for current != nil {
        if current.name == name do return current
        current = current.link
    }
    return nil
}