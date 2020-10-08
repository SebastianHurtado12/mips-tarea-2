.data
    numero: .asciiz "Introduzca su numero a factorizar:  "  # mensaje

.text
.globl main
main:

  li    $v0, 4                # print_string code
  la    $a0, numero           # numero char
  syscall                     # imprimimos el mensaje en la pantalla

  li    $v0, 5
  syscall                     # leo el numero introducido
  move  $a0, $v0              # almacenamos el numero en cuestion en t0


  jal    factorial        # llamamos a la funcion factorial

  move $a0, $v0
  li   $v0, 1
  syscall             # imprime el factorial
  li   $v0, 10        # syscall exit code
  syscall             # termina el programa


factorial:

  #incio del prologo
  addi $sp, $sp, -12	# hacer espacio para en el stack
  sw $a0, 0($sp)		  # guardar los registros que usamos
  sw $t2, 4($sp)
  sw $ra, 8($sp)
  #fin el prologo

  # designamos una funcion para los casos 1 y 0(CASO BASE)
  li     $t0, 1
  beq    $a0, $zero, f01      # si numero es igual a 0 salte a la funcion f01 (if t0==0 goto f01)
  beq    $a0, $t0, f01        # si numero es igual a 1 vaya a la funcion f01 (if t0==1 goto f01)

  # no estamos en caso base
  move   $t2, $a0            #  almacenamos el valor de a0 en t2
  addi $a0, $a0, -1	         #  restamos 1 a n
  jal factorial		           # factorial(n - 1)
  move $t1, $v0		           # copiamos el resultado factorial(n-1) a t1
  mul $v0, $t1, $t2	         # factorial (n-1) * n
  j return                   # goto return

f01:

  li $v0, 1               # almacenamos el valor 1 en v0
  j return                # goto return

return:
  #inicio del epilogo
  lw $a0, 0($sp)        # restauramos los registros que usamos
  lw $t2, 4($sp)
  lw $ra, 8($sp)
  addi $sp, $sp, 12     # liberar el espacio
  # fin del epilogo
  jr $ra                # volvemos al jal
