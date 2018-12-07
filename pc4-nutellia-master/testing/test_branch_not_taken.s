addi $r1, $r0, 8    #0 r1 = 8
addi $r2, $r0, 12	#1
and $r5, $r1, $r2	#2 r5 = 8
add $r17, $r1, $r0	#3 r17 = 8
add $r18, $r2, $r0	#4 r18=12
nop					#5
nop					#6
nop                 #7
nop					#8
#blt $r2, $r1, -6
bne $r1, $r5, -6	#9 DO NOT TAKE BRANCH
add $r19, $r1, $r5	#10 r19=16
