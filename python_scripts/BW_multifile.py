import sys
from PIL import Image

header = """
WIDTH =  1;
DEPTH =  """

header_2 = """;
ADDRESS_RADIX = HEX;
DATA_RADIX = HEX;
CONTENT BEGIN\n"""

input_filename = ["a.png", "b.png", "c.png", "d.png", "e.png", "f.png", "g.png", "h.png", "i.png", "j.png", "k.png", "l.png", "m.png", "n.png", "o.png", "p.png", "q.png", "r.png", "s.png", "t.png","u.png", "v.png", "w.png", "x.png","y.png", "z.png"]
output_filename = "letters.mif"

f = open(output_filename, 'w')

f.write(header)
f.write(str(50*50*26))
f.write(header_2)

pixel_index = 0
for x in input_filename:
  im = Image.open(x)
  print("writing: " + x)
  print(im.size)
  w = im.size[0]
  h = im.size[1]

  print("> Writing" + x +" to file: "+ output_filename)

  rgb_im = im.convert('RGB')

  for x in range(0, w):
    for y in range(0, h):
      r, g, b = rgb_im.getpixel((y,x))

      if(r==0):
        color_index = "0"
      else:
        color_index = "1"

      f.write(hex(pixel_index)[2:]+ ":\t" + color_index + ";\n")
      pixel_index += 1
      #print(pixel_index)

f.write("END;")

print(">>> DONE")
