import sys

header = """
WIDTH=24;
DEPTH=256;
ADDRESS_RADIX = HEX;
DATA_RADIX = HEX;
CONTENT BEGIN\n"""

input_filename = "color_table"
output_filename = "colors.mif"

read = open(input_filename, 'r');
write = open(output_filename, 'w');
print("Writing to colors.mif");

write.write(header)
index = 0
for x in range(0,256):
  line = read.readline()
  hex_color = line[9:-4]
  write.write(hex(index)[2:] + ":\t" + hex_color + ";\n")
  index+=1
write.write("END;")
print("DONE")




