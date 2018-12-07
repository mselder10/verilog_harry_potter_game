# TEST EVERY INSTRUCTION
addi $r1, $r0, 8    # r1 = 8
addi $r2, $r0, 12   # r2 = 12
add  $r3, $r1, $r1  # r3 = 16
sub  $r4, $r2, $r1  # r4 = 4
and  $r5, $r2, $r4  # r5 = 4
or   $r6, $r2, $r3  # 01100 || 10000 = 11100 = 28
sll  $r7, $r3, 1 	# r7 = 32
sra  $r8, $1, 1 	# r8 = 4

sw	 $r2, 10($r3)	# MEM[26] = 12
lw	 $r10, 2($r6)	# r10 = MEM[30] = -32
