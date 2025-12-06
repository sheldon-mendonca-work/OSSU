s = "azcbobobegghaklbob"
totalSum = 0
for i in range(0, len(s) - 2):
    if s[i: i+3] == "bob":
        totalSum = totalSum + 1 

print("Number of times bob occurs is:",totalSum)