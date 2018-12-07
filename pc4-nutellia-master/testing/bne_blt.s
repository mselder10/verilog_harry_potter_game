addi $r1, $r0, 8    #0 r1 = 8
addi $r2, $r0, 12   #1 r2 = 12
blt $r1, $r2, 3		#2 take branch
add $r4, $r1, $r2 	#3 r4 = 20 (after bne)
sub $r7, $r2, $r1	#4 r7 = 4 (after bne)
nop					#5
nop					#6
and $r5, $r1, $r2	#7 r5 = 8
add $r17, $r1, $r0	#8 r17 = 8
add $r18, $r2, $r0	#9 r18=12
nop					#10
bne $r1, $r5, -8	#11 don't take branch
bne $r2, $r1, -10	#12 take branch, jump back to add
