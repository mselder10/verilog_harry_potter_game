import sys
from PIL import Image


header = """
WIDTH =  24
DEPTH =  """

header_2 = """;
ADDRESS_RADIX = HEX;
DATA_RADIX = HEX;
CONTENT BEGIN\n"""

input_filename = "logo.png"
output_filename = "logo.mif"

im = Image.open(input_filename)

f = open(output_filename, 'w');

print("> Image size: ")
print(im.size)
print("")
w = im.size[0]
h = im.size[1]

print("> Writing to file: "+ output_filename)

f.write(header)
f.write(str(w*h))
f.write(header_2)

index = 0;

rgb_im = im.convert('RGB')

for x in range(0, w):
  for y in range(0, h):
    r, g, b = rgb_im.getpixel((x,y))

    hexr = "{:02x}".format(r)
    hexg = "{:02x}".format(g)
    hexb = "{:02x}".format(b)

    color = hexr + hexg + hexb
    f.write(hex(index)[2:] + ":\t" + color + ";\n")

    index += 1

f.write("END;")

print(">>> DONE");
