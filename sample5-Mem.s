		.data         
# dichiarazione dati
wVet1:    .word   2, 3
wVet2:    .word   10, 11
wRes:     .space  16    

# allocazione spazio in memoria per risultato

    .text
    .globl main
    .ent main
    
main:   lw $t1, wVet1       # caricamento dati
        lw $t2, wVet2                 
		add $t1, $t1, $t2 # esecuzione somma                 
		sw $t1, wRes       # salvataggio del risultato in memoria
                
		li $v0,10         # codice per uscita dal programma             	
        syscall           # fine
        
    .end main
