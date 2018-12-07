# this test fails to compute correct value
addi $r5, $r0, 10 	#0	r5 = 10
add $r10, $r5, $r5	#1	r10 = 20
mul $r7, $r10, $r5
