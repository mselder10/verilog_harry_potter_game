addi $r10, $r10, -100 #0
# r10 = -100
add $r11, $r11, $r10 #1
# r11 = -100
add $r12, $r10, $r11 #2 bne2 back here
# r12 = -200, r12 = -200
bne $r10, $r11, -3 #3
# don't take branch
bne $r12, $r11, -3 #4
# take branch
# return to add $r12, $r10, $r11
