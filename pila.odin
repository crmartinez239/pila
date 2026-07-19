package pila

import "core:fmt"
import "core:os"
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
    latest := kernel.init_dictionary()
    data_stack: [dynamic]u64
    
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
            fmt.println("pila program exit")
            break
        } else {
            fmt.println(token)
        }
    }

}