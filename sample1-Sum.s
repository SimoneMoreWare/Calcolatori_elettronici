		.data         
# dichiarazione dati
op1:            .byte 3
op2:            .byte 2
res:            .space 1      

# allocazione spazio in memoria per risultato

    .text
    .globl main
    .ent main
    
main:   lb $t1, op1       # caricamento dati
        lb $t2, op2                 
		    add $t1, $t1, $t2 # esecuzione somma                 
		    sb $t1, res       # salvataggio del risultato in memoria
                
		    li $v0,10         # codice per uscita dal programma             	
        syscall           # fine
        
    .end main
