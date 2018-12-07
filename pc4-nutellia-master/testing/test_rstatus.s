# test rstats
lw $r1, 0($r0)
# r1 = 2147483647
lw $r2, 1($r0)
# r2 = -2147483648
addi $r3, $r0, 1
# r3 = 1
addi $r15, $r1, 1
# r30 = 2 overflow, doesn't write r15 = 0
add $r4, $r1, $r3 
# r30 = 1 overflow, doesn't write r4 = 0
sub $r5, $r3, $r2 
# r30 = 3 overflow, doesn't write r5 = 0
add $r30, $r30, $r0 
# r30 = 3
setx 100
#r30 = 100
bex 1
