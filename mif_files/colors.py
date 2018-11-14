import sys
import array

header = """
WIDTH=24;
DEPTH=256;
ADDRESS_RADIX = HEX;
DATA_RADIX = HEX;
CONTENT BEGIN\n"""

output_filename = "colors.mif"

f = open(output_filename, 'w');
print("Writing to colors.mif");
f.write(header)
red = 0
green = 0
blue = 0

for x in range(0,256):
  hex_red = "{:02x}".format(red)
  hex_green = "{:02x}".format(green)
  hex_blue = "{:02x}".format(blue)
  hex_color = hex_red+hex_green+hex_blue

  f.write(hex(x)[2:] + ":\t" + hex_color + ";\n")

  red = red + 1
  green = green + 1
  blue = blue + 1

f.write("END;")

print(">>> DONE");

