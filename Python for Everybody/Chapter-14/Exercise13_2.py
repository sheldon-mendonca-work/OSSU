import json
import urllib.request

url = input('Enter location: ')
if len(url) < 1 : 
    # url = 'https://py4e-data.dr-chuck.net/comments_42.json'
    url = 'https://py4e-data.dr-chuck.net/comments_2075470.json'
    

print('Retrieving', url)
uh = urllib.request.urlopen(url)
data = uh.read()
print('Retrieved',len(data),'characters')

info = json.loads(data)
totalCount = 0
totalSum = 0

for item in info["comments"]:
    totalCount = totalCount + 1
    totalSum = totalSum + item["count"]

print("Count:", totalCount)
print("Sum:", totalSum)