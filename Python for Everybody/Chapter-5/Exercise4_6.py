def computepay(h, r):
    t = 0
    if h > 40:
        t = (h-40)*1.5*r
        h = 40
    t = t + h*r
    return t

try:
    inputHours = float(input("Enter the number of hours"))
    inputRate = float(input("Enter the rate per hour"))
except:
    print("Error in input during exceptions")
    quit()

totalPay = computepay(inputHours, inputRate)
print("Pay", totalPay)