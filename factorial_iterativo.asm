.data
    numero: .asciiz "Introduzca su numero a factorizar: \n "  # mensaje

.text
.globl main
main:

  li    $v0, 4                # print_string code
  la    $a0, numero           # numero char
  syscall                     # imprimimos el mensaje en la pantalla

  li    $v0, 5
  syscall                     # leo el numero introducido
  move  $t0, $v0              # almacenamos el numero en cuestion en t0

  # designamos una funcion para los casos 1 y 0

  beq    $t0, 0, f01  # si numero es igual a 0 salte a la funcion f01 (if t0==0 goto f01)
  beq    $t0, 1, f01  # si numero es igual a 1 vaya a la funcion f01 (if t0==1 goto f01)

  li $t1, 1           # inicializamos t1

  jal    factorial        # llamamos a la funcion factorial

  li   $v0, 10        # syscall exit code
  syscall             # termina el programa


factorial:


  beq  $t0, $zero, imprimir  # if(t3==0) goto factorial lo que produce while(t3 != 0)
  mul  $t1, $t1, $t0     # t1= t1*t0
  addi $t0, $t0, -1      # count --

  j factorial                # repite el loop

imprimir:                # imprimios el factorial en la consola

  li  $v0, 1
  move  $a0, $t1        # movemos el factorial a a0 para la sycall
  syscall               # imprimimos el multiplo

  jr    $ra          # volvemos al jal

f01:
  # no hacemos ningun tipo de calculo ya que el factorial de 1 y 0 son los mismos numeros

  li $v0, 1
  move $a0, $t0       # movemos el numero a a0 para la syscall
  syscall             # imprimos el numero en la consola
  li $v0, 10          # salimos del programa
  syscall
