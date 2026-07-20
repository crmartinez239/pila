package pila

import "core:fmt"
import "core:os"
import "core:strconv"

import "kernel"

COMMAND_VERSION :: "-v"
MESSAGE_FILE_READ_ERROR :: "Could not read file."

main :: proc() {
    if len(os.args) == 1 {
        usage()
        os.exit(1)
    }

    if os.args[1] == COMMAND_VERSION {
        version()
        os.exit(0)
    }

    source, err := os.read_entire_file_from_path(os.args[1], context.allocator)
    defer delete(source, context.allocator)
    
    if err != nil  {
        fmt.eprintln(MESSAGE_FILE_READ_ERROR)
        os.exit(1)
    }

    // pila vm init
    latest_word := kernel.init_dictionary()
    defer kernel.free_dictionary(latest_word)

    data_stack: [dynamic]u64
    defer delete(data_stack)
    
    // init outer interpreter
    parser := Parser {
        0, 
        ParserState.Interpret,  
        source,
    }

    // outer interpreter loop
    for {
        token := next_token(&parser)

        if token == "" {
            memory_dump(&data_stack, latest_word)
            fmt.println("pila program exit")
            break
        }

        word := kernel.find_word(token, latest_word)
        if word != nil {
            switch parser.state {
                case ParserState.Compile:
                    fallthrough
                
                case ParserState.Interpret:
                    word.cfa(&data_stack)
                    continue
            }
        }

        u, ok := strconv.parse_u64_of_base(token, 10)
        if ok {
            append(&data_stack, u)
            continue
        }

        // not a word or usable number
        fmt.eprintln("undefined word")
        os.exit(1)
    }

}

memory_dump :: proc(data_stack: ^[dynamic]u64, latest_word: ^kernel.Word) {
    fmt.printfln("data_stack -> %v", data_stack^)
}