             .data
msg1:        .asciiz "introduci il primo valore: "
msg2:        .asciiz "introduci il secondo valore: "
             .text
             .globl main
             .ent main
main:

li $v0, 4         
# syscall 4 (print_str)            
la $a0, msg1      
# argomento: stringa             
syscall           
# stampa la stringa             
li $v0, 5         
# syscall 5 (read_int)             
syscall         
move $t0, $v0     
# primo operando             
li $v0, 4            
la $a0, msg2             
syscall             
li $v0, 5             
syscall             
add $a0, $v0, $t0 # somma degli operandi             
li $v0, 1         # syscall 1 (print_int)
syscall          
li $v0,10         # codice per uscita dal programma          
syscall           
# fine
             
.end main
