addi $r2, $r0, 100
# r2 = 100
jal 256
# $r31 = 2
## sinstructions below should not execute until after jr
addi $r4, $r0, 35
add $r17, $r31, $r0
jr $r31 # move to 258
