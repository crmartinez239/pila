package pila

import "core:fmt"
import "core:os"

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

    parser := Parser{0, source}

    fmt.println(string(parser.source))
}