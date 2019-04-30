#a0 <- num
		.data
vetor: 		.space 10
		.text
set_array: 	add 	$t0, $zero, $zero
		add	$a0, $zero, 4
		
loop:		j	compare
		sw	$a1, $t0(vetor)
		addi	$t0, $t0, 1
		bne	$t2, 10, loop
		

compare: 	j	subtract
		slt	$t1, $t1, $zero
		bne	$t1, $zero, return1
		add	$a1, $zero, $zero
		jr	$ra
		
return1: 	add 	$a1, $zero, 1
		jr	$ra  

subtract:	sub	$t1, $a0, $t0
		jr	$ra


