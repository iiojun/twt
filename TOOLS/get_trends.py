#!/usr/bin/env python
# -*- coding: utf-8 -*-

###########################################################
# helper functions
###########################################################
import re

# escaping some special characters
def escape(s, quoted=u'\'"\\', escape=u'\\'):
  return re.sub(
            u'[%s]' % re.escape(quoted),
            lambda mo: escape + mo.group(),
            s)

# pretty printer for the nodes
def pp_node(ary_of_nodes):
  for node in ary_of_nodes:
    keyword = escape(node[0])
    frequency = node[1]
    print("node_hash['{0}'] = trend.nodes.create(word: '{1}', freq: {2:6.2f})"
            .format(keyword, keyword, frequency))

# pretty printer for the links
def pp_link(ary_of_links):
  for link in ary_of_links:
    (kw1,kw2) = link[0].split(',')
    print("link = Link.create(corr: {0:6.2f})".format(link[1]))
    print("node_hash['{0}'].links << link".format(escape(kw1)))
    print("node_hash['{0}'].links << link".format(escape(kw2)))

# normalize the hash value, the first argument has to be
# a dict object whose values are numerical data.
# parcentage is used if the second argument is True
def normalize(hash_obj, p_flag):
  maxval = max(hash_obj, key=lambda x: x[1])[1]
  factor = 100 if p_flag else 1
  return [(x[0], x[1] / maxval * factor) for x in hash_obj]

###########################################################
# creating words-graph
###########################################################
import MeCab

#PLASE MODIFY THE FOLLOWING INFORMATION
m = MeCab.Tagger("-d PATH_TO_MECAB_NEOLOGD")
#m = MeCab.Tagger("-d /usr/lib/x86_64-linux-gnu/mecab/dic/mecab-ipadic-neologd")
stopwords = {'*', 'HTTPS', 'HTTP', 'WWW', 'の', 'ん', 'ン', 'ω', '???'}

def create_graph(keyword, collected, tweets):
  ary_of_ary = []
  for tweet in tweets:
    ary = []
    lines = m.parse(tweet).split('\n')
    for line in lines:
      if line.count('\t') == 0: continue
      (kw, prop) = line.split('\t')
      props = prop.split(',')
      if len({props[-3]} & stopwords) > 0: continue
      if props[1] == '固有名詞':
        ary.append(props[-3])
    ary_of_ary.append(ary)

  KW_THRESHOLD = 20
  kw_dict = {}
  counter = 0
  for ary in ary_of_ary:
    for kw in ary:
      if kw in kw_dict:
        kw_dict[kw] = kw_dict[kw] + 1.0
      else:
        kw_dict[kw] = 1.0
      counter = counter + 1
  for kw,val in kw_dict.items():
    kw_dict[kw] = val / counter * 100

  if len(kw_dict) > 0:
    kw_dict = sorted(kw_dict.items(), 
                key = lambda x: x[1], reverse = True)[0:KW_THRESHOLD-1]
    kw_dict = normalize(kw_dict, True)
    print("node_hash = {}")
    print("trend = Trend.create(label: '{0}', collected:'{1}')"
              .format(escape(keyword), collected))
    pp_node(kw_dict)

  corr_dict = {}
  for src in kw_dict:
    for dst in kw_dict:
      if src == dst: continue
      src_w = src[0]
      dst_w = dst[0]
      sd_pair = src_w + "," + dst_w
      if sd_pair in corr_dict: continue
      prob = 0.0
      for ary in ary_of_ary:
        if ((src_w in ary) & (dst_w in ary)):
          prob = prob + 1.0
      prob = 100 * prob / len(ary_of_ary)
      if prob > 0:
        corr_dict[dst_w + "," + src_w] = prob

  if len(corr_dict) > 0:
    lk_dict = sorted(corr_dict.items(), key = lambda x: x[1], reverse = True)
    # shorten the list by cutting the latter 3/4 of items
    lk_dict = lk_dict[0:int(len(lk_dict)*1/4)]
    if len(lk_dict) > 0:
      lk_dict = normalize(lk_dict, True)
      pp_link(lk_dict) # pretty print for Links

###########################################################
# check if the (keyword, collected) has been already registered
###########################################################
import sqlite3
from contextlib import closing

def has_been_registered(keyword, collected):
  #PLASE MODIFY THE FOLLOWING INFORMATION
  dbfile = "PATH_TO_THE_DATABASE_FILE(development.sqlite3)"
  #dbfile = "/home/hikizo/twt/db/development.sqlite3"
  with closing(sqlite3.connect(dbfile)) as conn:
    c = conn.cursor()
    sql = 'select label, collected from trends where label=? and collected=?'
    res = (keyword, collected)
    c.execute(sql, res)
    return (len(c.fetchall()) > 0)

###########################################################
# the main function
###########################################################
from twitter import *
from datetime import date

def main():
  # please replase WOEID to your location
  woeid = 23424856 # Japan
  #PLASE MODIFY THE FOLLOWING INFORMATION
  CK = 'ADD_HERE_YOUR_CONSUMER_KEY'    # Consumer Key
  CS = 'ADD_HERE_YOUR_CONSUMER_SECRET'    # Consumer Secret
  AT = 'ADD_HERE_YOUR_ACCESS_TOKEN'    # Access Token
  AS = 'ADD_HERE_YOUR_ACCESS_TOKEN_SECRET'    # Accesss Token Secert

  twitter = Twitter(auth = OAuth(AT,AS,CK,CS))
  results = twitter.trends.place(_id = woeid, exclude="hashtags")
  # results = twitter.trends.place(_id = woeid)

  d = date.today()
  collected = d.strftime('%Y-%m-%d')

  for location in results:
    for trend in location["trends"]:
      keyword = trend["name"]
      if has_been_registered(keyword, collected): continue
      query_kw = keyword + " exclude:retweets exclude:nativeretweets"
      tw_rslts = twitter.search.tweets(q=query_kw, lang='ja', locale='ja', count=100)
      tw_ary = []
      for tweet in tw_rslts["statuses"]: tw_ary.append(tweet["text"])
      create_graph(keyword, collected, tw_ary)

if __name__ == "__main__": main()
