addi $r1, $r0, 2 			#0 r1 = 2
add $r15, $r1, $r1 			#1 $r15 = 4
j 6 						#2 JUMP TO ADDI
sub $r3, $r1, $r4  			#3 r3 = 2
add $r5, $r0, $r31 			#4 r5 = 11
jr $r31 					#5 JUMP TO ADDI @ 11
addi $r2, $r1, 2		 	#6 r2 = 4
jal 3 # JUMP TO SUBTRACTION #7 r31 = 11
addi $r20, $r0, 10000		#8
