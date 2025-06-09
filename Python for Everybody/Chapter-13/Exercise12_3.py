# To run this, download the BeautifulSoup zip file
# http://www.py4e.com/code3/bs4.zip
# and unzip it in the same directory as this file

import urllib.request, urllib.parse, urllib.error
from bs4 import BeautifulSoup
import ssl
import re

# Ignore SSL certificate errors
ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

url = input('Enter - ')
try:
    index = int(input('Enter position - '))
except:
    print("Index cannot be converted to int")
    quit()

try:
    depth = int(input('Enter depth - '))
except:
    print("Depth cannot be converted to int")
    quit()

while depth > 0:
    html = urllib.request.urlopen(url, context=ctx).read()
    soup = BeautifulSoup(html, 'html.parser')
    # # Retrieve all of the anchor tags
    tags = soup('a')
    url = tags[index - 1].get('href', None)
    depth = depth - 1

finalUrl = re.findall('known_by_(.+)\.html', url)
print(finalUrl[0])