fname = input("Enter file name: ")
fh = open(fname)
lst = list()
for line in fh:
    lt = line.split(' ')
    for word in lt:
        wd = word.strip()
        if wd not in lst:
            lst.append(wd)

lst.sort()
print(lst)