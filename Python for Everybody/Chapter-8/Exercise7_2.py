# Use the file name mbox-short.txt as the file name
fname = input("Enter file name: ")
try:
    fh = open(fname)
except:
    print("Could not open file: " + fname)
    quit()
val = 0
count = 0
len_str = len("X-DSPAM-Confidence:")
for line in fh:
    if not line.startswith("X-DSPAM-Confidence:"):
        continue
    num = float(line[len_str: ].strip())
    val = val + num
    count = count + 1

if count != 0:
    val = val/count
    
print("Average spam confidence: " + str(val))
