move $t2, $zero
move $t1, $zero
addi $t1, $zero, 10 

LOOP: 	slt $t2, $0, $t1
	bne $t2, $zero, ELSE
	j DONE
ELSE:	addi $s2, $s2, 2
	subi $t1,$t1, 1
	j LOOP
DONE: