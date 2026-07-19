package pila

Parser :: struct {
    pos: int,
    source: []u8,
}

@(private="file")
is_whitespace :: proc(c: u8) -> bool {
    switch c {
        case ' ', '\t', '\n':
            return true
        case:
            return false
    }
}

@(private="file")
skip_whitespace :: proc(parser: ^Parser) {
    for {
        if parser.pos >= len(parser.source) do break
        if is_whitespace(parser.source[parser.pos]) {
            parser.pos += 1
        } else {
            break
        }
    }
}

next_token :: proc(parser: ^Parser) -> string {
    skip_whitespace(parser)
    if parser.pos >= len(parser.source) do return ""
    start := parser.pos
    for i := start; i < len(parser.source); i += 1 {
        if !is_whitespace(parser.source[i]) {
            parser.pos += 1
            continue
        } else {
            break
        }
    }
    return string(parser.source[start: parser.pos])
}