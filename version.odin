package pila

import "core:fmt"

PILA_MAJOR :: "0"
PILA_MINOR :: "1"
PILA_PATCH :: "0"

PILA_VERSION :: 
    PILA_MAJOR + "." +
    PILA_MINOR + "." +
    PILA_PATCH

version :: proc() {
    fmt.println(PILA_VERSION);
}