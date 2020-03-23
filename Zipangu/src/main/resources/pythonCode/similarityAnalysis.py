from sklearn.feature_extraction.text import TfidfVectorizer
from konlpy.tag import Kkma
from konlpy.utils import pprint
import codecs
import cx_Oracle
import os
import re
from sklearn.feature_extraction.text import TfidfVectorizer
import pandas as pd
from datetime import datetime
import numpy as np
from sklearn.metrics.pairwise import linear_kernel

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
row = rows[0]

data = pd.read_sql(sql,conn)
data.loc[0] = ['','user','','','',keyword]
tfidf = TfidfVectorizer()
tfidf_matrix = tfidf.fit_transform(data['TEXT'])
tfidf_matrix = tfidf_matrix.astype(np.float32)
cosine_sim = linear_kernel(tfidf_matrix,tfidf_matrix)
indices = pd.Series(data.index, index=data['CONAME']).drop_duplicates()
#참고용 코사인 유사도 계산 함수
def cos_similarity(v1,v2):
    dot_product = np.dot(v1,v2)
    l2_norm = (np.sqrt(sum(np.square(v1))) * np.sqrt(sum(np.square(v2))))
    similarity = dot_product / l2_norm

    return similarity

def get_recommendations(title, cosine_sim=cosine_sim):
    idx = indices[title]
    sim_scores = list(enumerate(cosine_sim[idx]))
    sim_scores = sorted(sim_scores, key=lambda x: x[1], reverse=True)
    sim_scores = sim_scores[1:100]
    text_indices = [i[0] for i in sim_scores]

    return data['CONAME'].iloc[text_indices]

get_recommendations('user')
