import random;
import array;

header = """
WIDTH =  16;
DEPTH =  """

header_2 = """;
ADDRESS_RADIX = HEX;
DATA_RADIX = HEX;
CONTENT BEGIN\n"""

#output_filename = "traces.mif"
num_traces = 5;

f = open("traces.mif", 'w')

f.write(header)
f.write(str(num_traces))
f.write(header_2)

mif_index = 0;

for x in range (0, num_traces):
  trace = array.array('i', (0 for i in range(0,16)))
  f.write(hex(mif_index) + ": ")
  for k in range (0,16):
    random_bit = int(round(random.random()))
    #print("box (" + str(k) + ") RB: " + str(random_bit))
    # if row 0
    if(k/4 == 0):
      trace[k] = random_bit
    for m in range (4,16, 4):
      if(trace[k-4] == 1):
        trace[k] = random_bit;
      elif(k != m & trace[m-1] == 1 & random_bit):
				trace[k] = 1
      else:
				trace[k] = 0
  
  print("---------------")
  for x in range (0,16, 4):
    print(str(trace[x]) + str(trace[x+1]) + str(trace[x+2]) + str(trace[x+3]))
  print("---------------")
  for x in range(0,16):
    f.write(str(trace[x]))
  f.write(";\n")
