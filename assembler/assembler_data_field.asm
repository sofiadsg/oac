		.data
vetor: 		.asciiz "a:  .word 12, 15, 20\nb:  .word 22, 30, 30\n"
hex_to_ascii: 	.space 11
toFile:		.space 1
		.text
  		la 	$t6,vetor	#vetor que anda pelo buffer
  		addi	$t7, $zero, 0	#recebe o valor de t6
  		addi	$t8, $zero, 0	#aponta o lugar a ser escrito na memória
  		addi	$t9, $zero, 0	#aponta o valor a ser escrito na memória
 		la	$s0, toFile
 		addi	$s1, $zero, 0	#auxiliar
	
loop: 		lbu 	$t7, 0($t6)
		addi 	$t6, $t6, 1
		beq 	$t7, 0x2E, startVector
 		j 	loop
 
startVector:	lbu 	$t7, 0($t6)
		addi	$t6, $t6, 1
		bge	$t7, 0x30, smaller
		j	startVector
smaller:	ble	$t7, 0x39, buildNumber
		j	startVector
		
buildNumber:	addi	$t7, $t7, -0x30
		add	$t9, $t9, $t7
		lbu	$t7, 0($t6)
		addi	$t6, $t6, 1
		bge	$t7, 0x30, small
		j	writeVec
small:		ble	$t7, 0x39, multiply
		j	writeVec



multiply:	mul	$t9,$t9, 10
		j	buildNumber

writeVec:	addi	$v0, $t8, 0
		jal	hex_para_ascii
		jal	moveVec
		addi	$a0, $zero, ' '
		sb	$a0, -1($s0)
		addi	$a0, $zero, ':'
		sb	$a0, 0($s0)
		addi	$s0, $s0, 1
		addi	$a0, $zero, ' '
		addi	$v0, $t9, 0
		jal	hex_para_ascii
		jal 	moveVec
		addi	$a0, $zero, ';'
		sb	$a0, -1($s0)
		addi	$a0, $zero, '\n'
		sb	$a0, 0($s0)
		addi	$s0, $s0, 1
		addi	$t8, $t8, 4
		addi	$t9, $zero, 0
		j	startVector
		
		
		

moveVec:	la	$a2, hex_to_ascii
		addi	$a0, $zero, 0
moveLoop:	lb	$a1, 0($a2)
		sb	$a1, 0($s0)
		addi	$s0, $s0, 1
		addi	$a0, $a0, 1
		addi	$a2, $a2, 1
		blt	$a0, 9, moveLoop
		jr	$ra
		 
		
##### A PARTIR DAQUI ESTÁ IGUALZINHO A FUNÇÃO DO GABRIEL EXCETO FIM						
hex_para_ascii:	li 	$t4, -1
		li 	$t3, 32
		li 	$t5, 0

ciclo_hex_para_ascii:	addi $t3, $t3, -4
		addi $t5, $t5, 4
		addi $t4, $t4, 1
		beq $t4, 8, fim_conversao_hex_ascii
		srlv $t1, $v0, $t3
		sllv $v0, $v0, $t5
		srlv $v0, $v0, $t5
		beq $t1, 0x0, zero
		beq $t1, 0x1, um
		beq $t1, 0x2, dois
		beq $t1, 0x3, tres
		beq $t1, 0x4, quatro
		beq $t1, 0x5, cinco
		beq $t1, 0x6, seis
		beq $t1, 0x7, sete
		beq $t1, 0x8, oito
		beq $t1, 0x9, nove
		beq $t1, 0xa, dez
		beq $t1, 0xb, onze
		beq $t1, 0xc, doze
		beq $t1, 0xd, treze
		beq $t1, 0xe, quatorze
		beq $t1, 0xf, quinze

zero:
addiu $t1, $zero, '0'
sb $t1, hex_to_ascii($t4)
j ciclo_hex_para_ascii

um:
addiu $t1, $zero, '1'
sb $t1, hex_to_ascii($t4)
j ciclo_hex_para_ascii

dois:
addiu $t1, $zero, '2'
sb $t1, hex_to_ascii($t4)
j ciclo_hex_para_ascii

tres:
addiu $t1, $zero, '3'
sb $t1, hex_to_ascii($t4)
j ciclo_hex_para_ascii

quatro:
addiu $t1, $zero, '4'
sb $t1, hex_to_ascii($t4)
j ciclo_hex_para_ascii

cinco:
addiu $t1, $zero, '5'
sb $t1, hex_to_ascii($t4)
j ciclo_hex_para_ascii

seis:
addiu $t1, $zero, '6'
sb $t1, hex_to_ascii($t4)
j ciclo_hex_para_ascii

sete:
addiu $t1, $zero, '7'
sb $t1, hex_to_ascii($t4)
j ciclo_hex_para_ascii

oito:
addiu $t1, $zero, '8'
sb $t1, hex_to_ascii($t4)
j ciclo_hex_para_ascii

nove:
addiu $t1, $zero, '9'
sb $t1, hex_to_ascii($t4)
j ciclo_hex_para_ascii

dez:
addiu $t1, $zero, 'a'
sb $t1, hex_to_ascii($t4)
j ciclo_hex_para_ascii

onze:
addiu $t1, $zero, 'b'
sb $t1, hex_to_ascii($t4)
j ciclo_hex_para_ascii

doze:
addiu $t1, $zero, 'c'
sb $t1, hex_to_ascii($t4)
j ciclo_hex_para_ascii

treze:
addiu $t1, $zero, 'd'
sb $t1, hex_to_ascii($t4)
j ciclo_hex_para_ascii

quatorze:
addiu $t1, $zero, 'e'
sb $t1, hex_to_ascii($t4)
j ciclo_hex_para_ascii

quinze:
addiu $t1, $zero, 'f'
sb $t1, hex_to_ascii($t4)
j ciclo_hex_para_ascii

fim_conversao_hex_ascii: jr	$ra		