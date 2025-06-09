inputHours = float(input("Enter the number of hours"))
inputRate = float(input("Enter the rate per hour"))

totalPay = 0

if inputHours > 40:
    totalPay = (inputHours - 40) * 1.5 * inputRate
    inputHours = 40
    
totalPay = totalPay + inputHours*inputRate

print(totalPay)