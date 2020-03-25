from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.feature_extraction.text import CountVectorizer
from konlpy.tag import Kkma
from konlpy.utils import pprint
import codecs
import cx_Oracle
import os
import re
import pandas as pd
from datetime import datetime
import numpy as np
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
sql = "select * from company order by company_num"
cursor.execute(sql)
cursor.rowfactory = makeDictFactory(cursor)

rows = cursor.fetchall()

type_array = []
for data in rows:
    type_array.append(data['TYPE'])

type_array = list(set(type_array))

total_com = []
for type in type_array:
    temp = []
    for data in rows:
        if data['TYPE'] == type:
            temp.append(data['TEXT'])
    temp.insert(0,type)
    total_com.append(temp)

total_features = []
for array in total_com:
    feature = []
    feature.append(array[0])
    vectorize = CountVectorizer(min_df=0.3)
    X = vectorize.fit_transform(array)
    features = vectorize.get_feature_names()
    feature.append(features)
    total_features.append(feature)

num = 0
total_result = []
while num <= 125:
    data = total_features[num]
    feature_list = data[1]
    countDict = dict()
    titleDict = dict()
    temp = []
    for feature in feature_list:
        sql = "select count(*) from company where type = :typeparam"
        cursor.execute(sql,typeparam=data[0])
        cursor.rowfactory = makeDictFactory(cursor)
        result = cursor.fetchall()
        result = result[0]
        countDict[data[0]] = result['COUNT(*)']
        sql = "select count(*) from company where type = :typeparam and instr(text,:param)>0"
        cursor.execute(sql,typeparam=data[0],param=feature)
        cursor.rowfactory = makeDictFactory(cursor)
        result = cursor.fetchall()
        result = result[0]
        titleDict[feature] = result['COUNT(*)']
    temp.append(titleDict)
    temp.append(countDict)
    total_result.append(temp)
    num += 1

def insert_weight_tbl(weight_arr):
    sql = "insert into weight_tbl(type_no, type, key, value) values(:type_no, :type, :key, :value)"
    cursor.executemany(sql,weight_arr)
    conn.commit()

num = 0
weight_arr = []
while num <= 125:
    idx = num + 1
    type_no = idx
    type = list(total_result[num][1].keys())[0]
    totalCount = list(total_result[num][1].values())[0]
    for key, value in total_result[num][0].items():
        weight_tuple = (type_no, type, key, value/totalCount)
        weight_arr.append(weight_tuple)
    num += 1
