text = "X-DSPAM-Confidence:    0.8475"
index = text.find('0')
num = float(text[index: ])
print(num)
