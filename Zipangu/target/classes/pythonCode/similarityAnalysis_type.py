from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.feature_extraction.text import CountVectorizer
from konlpy.tag import Kkma
import cx_Oracle
import os
import pandas as pd
from pandas import DataFrame as df
from datetime import datetime
import numpy as np
from sklearn.metrics.pairwise import linear_kernel

os.environ['NLS_LANG'] = '.UTF8'

f = open(r"D:\user\Desktop\text6.txt", 'rb')
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

df2 = pd.DataFrame(columns=['TYPE','TEXT'])
num = 0
while num <=125:
    text = ' '.join(total_features[num][1])
    df2.loc[num] = [total_features[num][0], text]
    num += 1

df1 = df(data={'TYPE':['user'],'TEXT':keyword})
df2.loc[126] = ['user',keyword]

tfidf = TfidfVectorizer()
tfidf_matrix = tfidf.fit_transform(df2['TEXT'])
tfidf_matrix = tfidf_matrix.astype(np.float32)
cosine_sim = linear_kernel(tfidf_matrix,tfidf_matrix)
indices = pd.Series(df2.index, index=df2['TYPE']).drop_duplicates()

def cos_similarity(v1,v2):
    dot_product = np.dot(v1,v2)
    l2_norm = (np.sqrt(sum(np.square(v1))) * np.sqrt(sum(np.square(v2))))
    similarity = dot_product / l2_norm
    
def get_recommendations(title, cosine_sim=cosine_sim):
    idx = indices[title]
    sim_scores = list(enumerate(cosine_sim[idx]))
    sim_scores = sorted(sim_scores, key=lambda x: x[1], reverse=True)
    sim_scores = sim_scores[1:10]
    text_indices = [i[0] for i in sim_scores]

    return df2['TYPE'].iloc[text_indices]
