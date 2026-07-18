package pila

import "core:fmt"
import "core:os"

main :: proc() {
    if len(os.args) == 1 {
        usage()
        os.exit(1)
    }

    source, err := os.read_entire_file_from_path(os.args[1], context.allocator)
    if err != nil  {
        fmt.eprintln("Could not read file.")
        os.exit(1)
    }

    defer delete(source, context.allocator)

    fmt.println(string(source))
}