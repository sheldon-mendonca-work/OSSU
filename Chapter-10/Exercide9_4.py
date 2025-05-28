name = input("Enter file:")
if len(name) < 1:
    name = "mbox-short.txt"
handle = open(name)
mails = dict()
for line in handle:
    if line[0:5] == 'From ':
        wd = line.split(' ')[1].strip()
        mails[wd] = mails.get(wd, 0) + 1

nm = None
val = None
for key,value in mails.items():
    if val is None or value > val:
        nm = key
        val = value
        
print(nm, val)