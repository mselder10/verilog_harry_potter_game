import sys
from PIL import Image
from colormath.color_objects import XYZColor, sRGBColor, LabColor
from colormath.color_conversions import convert_color
from colormath.color_diff import delta_e_cie1976

header = """
WIDTH =  8;
DEPTH =  """

header_2 = """;
ADDRESS_RADIX = HEX;
DATA_RADIX = HEX;
CONTENT BEGIN\n"""

color_palette = "color_palette"

input_filename = "gryffindor.png"
output_filename = "gryffindor.mif"

im = Image.open(input_filename)

f = open(output_filename, 'w');
c = open(color_palette, 'r');

print("> Image size: ")
print(im.size)
print("")
w = im.size[0]
h = im.size[1]

print("> Writing to file: "+ output_filename)

f.write(header)
f.write(str(w*h))
f.write(header_2)

pixel_index = 0;

rgb_im = im.convert('RGB')

mycolors = []
# create LabColor space for colors in colors.mif
for x in range(0,256):
  # read from color palette
  line = c.readline()
  pc = line.rstrip("\n")
  # convert to LabColor object for matching
  pal_rgb = sRGBColor.new_from_rgb_hex(pc)
  #pal_xyz = convert_color(pal_rgb, XYZColor)
  # add color to list
  mycolors.append(convert_color(pal_rgb, LabColor))

for x in range(0, w):
  for y in range(0, h):
    # get pixel's rgb value
    r, g, b = rgb_im.getpixel((x,y))

    # make conversion to LabColor for color matching
    rgb = sRGBColor(r/255, g/255, b/255)
    lab = convert_color(rgb, LabColor)

    # find the best color match
    min_dif = 1000000000000.0
    color_index = 0
    index = 0
    counter = 0;
    differences = []
    for color in mycolors:
      # use CIE Lab index
      delta_e = delta_e_cie1976(lab, color)
      differences.append(delta_e)

    color_index = differences.index(min(differences))
    hex_color_index = "{:02x}".format(color_index)
    print(hex_color_index)
    # write to mif file
    f.write(hex(pixel_index)[2:] + ":\t" + hex_color_index + ";\n")

    # increment address of mif file
    pixel_index += 1
    print(pixel_index)

f.write("END;")

print(">>> DONE");
