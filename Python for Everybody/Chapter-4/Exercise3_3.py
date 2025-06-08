inputScore = input("Enter a score: ")

try:
    score = float(inputScore)
    if score < 0 or score > 1:
        raise Exception("Score is not within defined range")
except:
    print("Error, invalid input")
    quit()

if score >= 0.9:
    print("A")
elif score >= 0.8:
    print("B")
elif score >= 0.7:
    print("C")
elif score >= 0.6:
    print("D")
else:
    print("F")
