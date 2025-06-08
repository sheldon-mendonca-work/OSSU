import re

try:
    fileName = input("Enter the file name: ")
    if len(fileName.strip()) == 0:
        raise ValueError("Invalid file name")
    file = open(fileName, "r")
except (OSError, ValueError) as e:
    print(f"Error in opening file: {e}")
    quit()

totalSum = 0
for line in file:
    numberList = re.findall("[0-9]+", line)
    for num in numberList:
        totalSum += int(num)
        
print(totalSum)