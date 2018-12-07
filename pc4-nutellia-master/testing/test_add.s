addi $r2, $r0, 12 
# r2 = 12 GOOD
addi $r3, $r0, 200
#r3 = 200 GOOD
add $r4, $r2, $r3
#r4 = 212 GOOD
sub $r5, $r3, $r2
# r5 = 188 BAD --> fixed w bypass
# gets 200, 200-0, r3 bypass but r2 hasn't written yet
# fd.ctrl_readRegA = mw.rd
sub $r6, $r4, $r3 
# r6 = 12 BAD --> fixed w bypass
# gets 212, 212-0, r4 bypass but r3 hasn't written yet
# fd.ctrl_readRegB = mw.rd
