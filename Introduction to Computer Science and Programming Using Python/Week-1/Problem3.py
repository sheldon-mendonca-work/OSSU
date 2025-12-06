s = 'azcbobobegghakl'
curr = s[0]
res = s[0]

for i in range(1, len(s)):
    if s[i] >= s[i-1]:
        curr = curr + s[i]
        if len(curr) > len(res):
            res = curr
    else:
        curr = s[i]

print("Longest substring in alphabetical order is:", res)