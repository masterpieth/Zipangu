from sklearn.feature_extraction.text import TfidfVectorizer
from konlpy.tag import Kkma
from konlpy.utils import pprint
import codecs
import cx_Oracle
import os
import re
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.feature_extraction.text import CountVectorizer
import pandas as pd
from datetime import datetime
import numpy as np
from numpy import dot
from numpy.linalg import norm
from sklearn.metrics.pairwise import linear_kernel
import getpass

os.environ['NLS_LANG'] = '.UTF8'

f = open(r"D:\user\Desktop\testtest.txt", 'rb')
lines = f.read()
text = lines.decode(encoding='utf-8')

kkma = Kkma()
keyword = ' '.join(kkma.nouns(text))

def makeDictFactory(cursor):
    columnNames = [d[0] for d in cursor.description]

    def createRow(*args):
        return dict(zip(columnNames, args))

    return createRow

def OutputTypeHandler(cursor, name, defaultType, size, precision, scale):
    if defaultType == cx_Oracle.CLOB:
        return cursor.var(cx_Oracle.LONG_STRING, arraysize = cursor.arraysize)

conn = cx_Oracle.connect("hr/hr@localhost:1521/xe")
conn.outputtypehandler = OutputTypeHandler
conn.encoding
cursor = conn.cursor()
sql = 'select * from company order by company_num'
cursor.execute(sql)

cursor.rowfactory = makeDictFactory(cursor)

rows = cursor.fetchall()
from collections import Counter
str_list = rows[0]['TEXT'].split(' ')
count = Counter(str_list)
tag_count = []
tags = []
for n, c in count.most_common(100):
    dics = {'tag': n, 'count': c}
    if len(dics['tag']) >= 2 and len(tags) <= 49:
        tag_count.append(dics)
        tags.append(dics['tag'])

for tag in tag_count:
    print(" {:<14}".format(tag['tag']), end='\t')
    print("{}".format(tag['count']))

