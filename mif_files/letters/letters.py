import sys
from PIL import Image

header = """
WIDTH =  2;
DEPTH =  """

header_2 = """;
ADDRESS_RADIX = HEX;
DATA_RADIX = HEX;
CONTENT BEGIN\n"""

output_filename = "letters.mif"

f = open(output_filename, 'w')

f.write(header)
f.write(str(50*50*26))
f.write(header_2)
w = 50
h = 50
pixel_index = 0
a = Image.open("a.png")
a_rgb =a.convert('RGB')
for x in range(0, w):
	for y in range(0, h):
		r, g, b =a_rgb.getpixel((y,x))
		if(r==0):
			color_index="0"
		else: 
			color_index ="1"
		out = hex(pixel_index)[2:]+":\t"+ color_index +";"
		print(out) 
		f.write(out +"\n")
		pixel_index += 1
b = Image.open("b.png")
b_rgb =b.convert('RGB')
for x in range(0, w):
	for y in range(0, h):
		r, g, b =b_rgb.getpixel((y,x))
		if(r==0):
			color_index="0"
		else: 
			color_index ="1"
		out = hex(pixel_index)[2:]+":\t"+ color_index +";"
		print(out) 
		f.write(out +"\n")
		pixel_index += 1
c = Image.open("c.png")
c_rgb =c.convert('RGB')
for x in range(0, w):
	for y in range(0, h):
		r, g, b =c_rgb.getpixel((y,x))
		if(r==0):
			color_index="0"
		else: 
			color_index ="1"
		out = hex(pixel_index)[2:]+":\t"+ color_index +";"
		print(out) 
		f.write(out +"\n")
		pixel_index += 1
d = Image.open("d.png")
d_rgb =d.convert('RGB')
for x in range(0, w):
	for y in range(0, h):
		r, g, b =d_rgb.getpixel((y,x))
		if(r==0):
			color_index="0"
		else: 
			color_index ="1"
		out = hex(pixel_index)[2:]+":\t"+ color_index +";"
		print(out) 
		f.write(out +"\n")
		pixel_index += 1
e = Image.open("e.png")
e_rgb =e.convert('RGB')
for x in range(0, w):
	for y in range(0, h):
		r, g, b =e_rgb.getpixel((y,x))
		if(r==0):
			color_index="0"
		else: 
			color_index ="1"
		out = hex(pixel_index)[2:]+":\t"+ color_index +";"
		print(out) 
		f.write(out +"\n")
		pixel_index += 1
f = Image.open("f.png")
f_rgb =f.convert('RGB')
for x in range(0, w):
	for y in range(0, h):
		r, g, b =f_rgb.getpixel((y,x))
		if(r==0):
			color_index="0"
		else: 
			color_index ="1"
		out = hex(pixel_index)[2:]+":\t"+ color_index +";"
		print(out) 
		f.write(out +"\n")
		pixel_index += 1
g = Image.open("g.png")
g_rgb =g.convert('RGB')
for x in range(0, w):
	for y in range(0, h):
		r, g, b =g_rgb.getpixel((y,x))
		if(r==0):
			color_index="0"
		else: 
			color_index ="1"
		out = hex(pixel_index)[2:]+":\t"+ color_index +";"
		print(out) 
		f.write(out +"\n")
		pixel_index += 1
h = Image.open("h.png")
h_rgb =h.convert('RGB')
for x in range(0, w):
	for y in range(0, h):
		r, g, b =h_rgb.getpixel((y,x))
		if(r==0):
			color_index="0"
		else: 
			color_index ="1"
		out = hex(pixel_index)[2:]+":\t"+ color_index +";"
		print(out) 
		f.write(out +"\n")
		pixel_index += 1
i = Image.open("i.png")
i_rgb =i.convert('RGB')
for x in range(0, w):
	for y in range(0, h):
		r, g, b =i_rgb.getpixel((y,x))
		if(r==0):
			color_index="0"
		else: 
			color_index ="1"
		out = hex(pixel_index)[2:]+":\t"+ color_index +";"
		print(out) 
		f.write(out +"\n")
		pixel_index += 1
j = Image.open("j.png")
j_rgb =j.convert('RGB')
for x in range(0, w):
	for y in range(0, h):
		r, g, b =j_rgb.getpixel((y,x))
		if(r==0):
			color_index="0"
		else: 
			color_index ="1"
		out = hex(pixel_index)[2:]+":\t"+ color_index +";"
		print(out) 
		f.write(out +"\n")
		pixel_index += 1
k = Image.open("k.png")
k_rgb =k.convert('RGB')
for x in range(0, w):
	for y in range(0, h):
		r, g, b =k_rgb.getpixel((y,x))
		if(r==0):
			color_index="0"
		else: 
			color_index ="1"
		out = hex(pixel_index)[2:]+":\t"+ color_index +";"
		print(out) 
		f.write(out +"\n")
		pixel_index += 1
l = Image.open("l.png")
l_rgb =l.convert('RGB')
for x in range(0, w):
	for y in range(0, h):
		r, g, b =l_rgb.getpixel((y,x))
		if(r==0):
			color_index="0"
		else: 
			color_index ="1"
		out = hex(pixel_index)[2:]+":\t"+ color_index +";"
		print(out) 
		f.write(out +"\n")
		pixel_index += 1
m = Image.open("m.png")
m_rgb =m.convert('RGB')
for x in range(0, w):
	for y in range(0, h):
		r, g, b =m_rgb.getpixel((y,x))
		if(r==0):
			color_index="0"
		else: 
			color_index ="1"
		out = hex(pixel_index)[2:]+":\t"+ color_index +";"
		print(out) 
		f.write(out +"\n")
		pixel_index += 1
n = Image.open("n.png")
n_rgb =n.convert('RGB')
for x in range(0, w):
	for y in range(0, h):
		r, g, b =n_rgb.getpixel((y,x))
		if(r==0):
			color_index="0"
		else: 
			color_index ="1"
		out = hex(pixel_index)[2:]+":\t"+ color_index +";"
		print(out) 
		f.write(out +"\n")
		pixel_index += 1
o = Image.open("o.png")
o_rgb =o.convert('RGB')
for x in range(0, w):
	for y in range(0, h):
		r, g, b =o_rgb.getpixel((y,x))
		if(r==0):
			color_index="0"
		else: 
			color_index ="1"
		out = hex(pixel_index)[2:]+":\t"+ color_index +";"
		print(out) 
		f.write(out +"\n")
		pixel_index += 1
p = Image.open("p.png")
p_rgb =p.convert('RGB')
for x in range(0, w):
	for y in range(0, h):
		r, g, b =p_rgb.getpixel((y,x))
		if(r==0):
			color_index="0"
		else: 
			color_index ="1"
		out = hex(pixel_index)[2:]+":\t"+ color_index +";"
		print(out) 
		f.write(out +"\n")
		pixel_index += 1
q = Image.open("q.png")
q_rgb =q.convert('RGB')
for x in range(0, w):
	for y in range(0, h):
		r, g, b =q_rgb.getpixel((y,x))
		if(r==0):
			color_index="0"
		else: 
			color_index ="1"
		out = hex(pixel_index)[2:]+":\t"+ color_index +";"
		print(out) 
		f.write(out +"\n")
		pixel_index += 1
r = Image.open("r.png")
r_rgb =r.convert('RGB')
for x in range(0, w):
	for y in range(0, h):
		r, g, b =r_rgb.getpixel((y,x))
		if(r==0):
			color_index="0"
		else: 
			color_index ="1"
		out = hex(pixel_index)[2:]+":\t"+ color_index +";"
		print(out) 
		f.write(out +"\n")
		pixel_index += 1
s = Image.open("s.png")
s_rgb =s.convert('RGB')
for x in range(0, w):
	for y in range(0, h):
		r, g, b =s_rgb.getpixel((y,x))
		if(r==0):
			color_index="0"
		else: 
			color_index ="1"
		out = hex(pixel_index)[2:]+":\t"+ color_index +";"
		print(out) 
		f.write(out +"\n")
		pixel_index += 1
t = Image.open("t.png")
t_rgb =t.convert('RGB')
for x in range(0, w):
	for y in range(0, h):
		r, g, b =t_rgb.getpixel((y,x))
		if(r==0):
			color_index="0"
		else: 
			color_index ="1"
		out = hex(pixel_index)[2:]+":\t"+ color_index +";"
		print(out) 
		f.write(out +"\n")
		pixel_index += 1
u = Image.open("u.png")
u_rgb =u.convert('RGB')
for x in range(0, w):
	for y in range(0, h):
		r, g, b =u_rgb.getpixel((y,x))
		if(r==0):
			color_index="0"
		else: 
			color_index ="1"
		out = hex(pixel_index)[2:]+":\t"+ color_index +";"
		print(out) 
		f.write(out +"\n")
		pixel_index += 1
v = Image.open("v.png")
v_rgb =v.convert('RGB')
for x in range(0, w):
	for y in range(0, h):
		r, g, b =v_rgb.getpixel((y,x))
		if(r==0):
			color_index="0"
		else: 
			color_index ="1"
		out = hex(pixel_index)[2:]+":\t"+ color_index +";"
		print(out) 
		f.write(out +"\n")
		pixel_index += 1
w = Image.open("w.png")
w_rgb =w.convert('RGB')
for x in range(0, w):
	for y in range(0, h):
		r, g, b =w_rgb.getpixel((y,x))
		if(r==0):
			color_index="0"
		else: 
			color_index ="1"
		out = hex(pixel_index)[2:]+":\t"+ color_index +";"
		print(out) 
		f.write(out +"\n")
		pixel_index += 1
x = Image.open("x.png")
x_rgb =x.convert('RGB')
for x in range(0, w):
	for y in range(0, h):
		r, g, b =x_rgb.getpixel((y,x))
		if(r==0):
			color_index="0"
		else: 
			color_index ="1"
		out = hex(pixel_index)[2:]+":\t"+ color_index +";"
		print(out) 
		f.write(out +"\n")
		pixel_index += 1
y = Image.open("y.png")
y_rgb =y.convert('RGB')
for x in range(0, w):
	for y in range(0, h):
		r, g, b =y_rgb.getpixel((y,x))
		if(r==0):
			color_index="0"
		else: 
			color_index ="1"
		out = hex(pixel_index)[2:]+":\t"+ color_index +";"
		print(out) 
		f.write(out +"\n")
		pixel_index += 1
z = Image.open("z.png")
z_rgb =z.convert('RGB')
for x in range(0, w):
	for y in range(0, h):
		r, g, b =z_rgb.getpixel((y,x))
		if(r==0):
			color_index="0"
		else: 
			color_index ="1"
		out = hex(pixel_index)[2:]+":\t"+ color_index +";"
		print(out) 
		f.write(out +"\n")
		pixel_index += 1
f.write("END;")

print(">>> DONE")
