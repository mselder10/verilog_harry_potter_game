import sys
from PIL import Image

header = """
WIDTH =  2;
DEPTH =  """

header_2 = """;
ADDRESS_RADIX = HEX;
DATA_RADIX = BINARY;
CONTENT BEGIN\n"""

input_filename = "crestbw.png"
output_filename = "crestbw.mif"

im = Image.open(input_filename)

f = open(output_filename, 'w')

print("> Image size: ")
print(im.size)
print("")
w = 100
h = 100

print("> Writing to file: "+ output_filename)

f.write(header)
f.write(str(w*h))
f.write(header_2)

pixel_index = 0

rgb_im = im.convert('RGB')

for x in range(0, w):
  for y in range(0, h):
    r, g, b = rgb_im.getpixel((y,x))

    if(r==0):
      color_index = "00"
    elif(r == 192):
      color_index = "10"
    else:
      color_index = "01"

    out = hex(pixel_index)[2:] + ":\t" + color_index + ";"
  
    print(out)
    f.write(out + "\n")

    pixel_index += 1

f.write("END;")

print(">>> DONE")
