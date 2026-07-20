package pila

import "core:fmt"
import "core:os"
import "core:strconv"

import "kernel"

COMMAND_VERSION :: "-v"
MESSAGE_FILE_READ_ERROR :: "Could not read file."

main :: proc() {
    // if len(os.args) == 1 {
    //     usage()
    //     os.exit(1)
    // }

    // if os.args[1] == COMMAND_VERSION {
    //     version()
    //     os.exit(0)
    // }



    // source, err := os.read_entire_file_from_path(os.args[1], context.allocator)
    // defer delete(source, context.allocator)
    
    // if err != nil  {
    //     fmt.eprintln(MESSAGE_FILE_READ_ERROR)
    //     os.exit(1)
    // }

    // pila vm init
    latest := kernel.init_dictionary()
    
    data_stack: [dynamic]u64
    defer delete(data_stack)
    
    // init outer interpreter
    parser := Parser {
        0, 
        ParserState.Interpret,  
        nil,
    }

    // outer interpreter loop
    for {
        fmt.print("> ")

        token, ok := read_input_as_string()
        if !ok {
            fmt.eprintln("fatal error: could not read input")
            os.exit(1)
        }
        
        //token := next_token(&parser)

        // if token == "" {
        //     fmt.println("pila program exit")
        //     break
        // }

        word := kernel.find_word(token, latest)
        if word != nil {
            switch parser.state {
                case ParserState.Compile:
                    fallthrough
                case ParserState.Interpret:
                    word.cfa(&data_stack)
                    fmt.print(" ok")
            }

            continue
        }

        u, tickok := strconv.parse_u64_of_base(token, 10)
        if tickok {
            append(&data_stack, u)
            continue
        }

        // not a word or usable number
        fmt.eprintln("undefined word")
        os.exit(1)
    }

}

read_input_as_string :: proc() -> (string, bool) {
    buf: [2048]u8
    n, err := os.read(os.stdin, buf[:])
    if err != nil do return "", false
    return string(buf[:n - 1]), true
}