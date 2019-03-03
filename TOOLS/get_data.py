#!/usr/bin/env python

import json
import urllib.request
import sys
import re

# replace urlbase to the base address of your application
# this script should be called as $ ./get_data.py 2019-02-01
# which means the argument should be a date formatted in YYYY-MM-DD
urlbase = 'http://iiojun.xyz/twt'
jsonapi = '/api/' + sys.argv[1]

word_dict = {}
words = [] 

req = urllib.request.Request(urlbase+jsonapi)
with urllib.request.urlopen(req) as res:
  content = json.loads(res.read().decode('utf8'))
  # loop for labels
  for item in content:
    label = item['label']
    wid = item['id']
    url2 = "{0}/api/trends/{1}".format(urlbase, wid)
    req2 = urllib.request.Request(url2)
    dct = {}
    # loop for words of each label
    with urllib.request.urlopen(req2) as res2:
      content2 = json.loads(res2.read().decode('utf8'))
      for item2 in content2[0]:
        word = item2['word']
        freq = item2['freq']
        dct[word] = freq
        # keep the all words used in the nodes in the array 'words'
        if not word in words: words.append(word)
      # keep the ary of {word, freq} in the dictionary 'word_dict'
      word_dict[label] = dct

print("label", end="")
for item in words:
  print("\t{0}".format(item), end="")
print()

for key in word_dict:
  print(key, end="")
  dct = word_dict[key]
  for item in words:
    freq = dct[item] if item in dct else 0.0
    print("\t%6.3f" % freq, end="")
  print()
