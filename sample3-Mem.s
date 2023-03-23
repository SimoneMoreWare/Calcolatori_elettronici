             .data
variabile:   .space 4    # int variabile
             .text
             .globl main
             .ent main
main:

             li  $t0, 19591501      # variabile = 19591501 (012A F14D hex)
             sw  $t0, variabile

             li $v0, 10
             syscall 

             .end main
