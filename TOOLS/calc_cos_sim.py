#!/usr/bin/env python3

import numpy as np
import sys

def cos_sim(v1, v2):
    return np.dot(v1, v2) / (np.linalg.norm(v1) * np.linalg.norm(v2))

lines = sys.stdin.readlines()

lines.pop(0)
wdic = {}
visited = []

for line in lines:
  words = line.split('\t')
  label = words.pop(0)
  wdic[label] = list(map(lambda x: float(x),words))

for key1 in wdic:
  for key2 in wdic:
    visited.append(key2+key1)
    if key1 == key2 or key1+key2 in visited: continue
    print("{0}\t{1}\t{2:9.6f}".format(key1,key2,cos_sim(wdic[key1],wdic[key2])))
