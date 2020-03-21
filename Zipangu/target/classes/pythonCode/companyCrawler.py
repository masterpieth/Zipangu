from urllib.request import urlopen
from bs4 import BeautifulSoup
from google.cloud import translate_v2 as translate
from konlpy.tag import Kkma
from konlpy.utils import pprint
from py4j.java_gateway import JavaGateway
import cx_Oracle
import re
import os
os.environ['NLS_LANG'] = '.UTF8'

def cleanText(data):
    text = re.sub('[-=+,#/\?:^$.@*\"※~&%ㆍ!』\\‘|\(\)\[\]\<\>`\'…》]', '',data)
    return text

urlkey_list = []
num = 1
while num <= 1:
    html = urlopen('https://job.rikunabi.com/2021/s/?isc=ps054&pn='+str(num))
    soup = BeautifulSoup(html, 'html.parser', from_encoding='utf-8')
    input_list = soup.find_all('input',{'class':'js-h-search-cassetteKokyakuCd'})
    for input in input_list:
        urlkey_list.append(input.get('value'))
    num = num + 1

total_company = []
temp_list = []
for urlkey in urlkey_list:
    html = urlopen('https://job.rikunabi.com/2021/company/'+ urlkey + '/')
    soup = BeautifulSoup(html, 'html.parser', from_encoding='utf-8')
    sentence_list = soup.findAll('p',{'class':'ts-h-company-sentence'})
    sentence_list.append(soup.find('div',{'class':'ts-h-company-sentence'}))
    
    text_list = []
    for sentence in sentence_list:
        text_list.append(sentence.text)
    
    html = urlopen('https://job.rikunabi.com/2021/company/'+ urlkey + '/employ/')
    soup = BeautifulSoup(html, 'html.parser', from_encoding='utf-8')
    div = soup.find('div',{'class':'ts-h-company-media02-main ts-s-mb28'})
    if div is not None:
        text_list.append(div.text)
    elif div is None:
        text_list.append(' ')
        
    str = ''
    for string in text_list:
        str = str + string
    gateway = JavaGateway()
    nouns = gateway.kuromoji(str)
    client = translate.Client()
    result = client.translate(nouns, target_language='ko')
    nouns = result['translatedText']
    nouns = cleanText(nouns)
    
    company = []
    h1 = soup.find('h1',{'class':'ts-h-company-mainTitle'})
    company.append(h1.text)
    div = soup.findAll('div',{'class':'ts-h-company-dataTable-main'})
    for data in div:
        company.append(data.text)
    info = soup.select('#company-data04 > div.ts-h-company-sentence')
    company.append(info[0].text)
    company.append(nouns)
    company_tuple = (company[0],company[1],company[2],company[3],company[4])
    total_company.append(company_tuple)
    total_company = list(set(total_company))

def insert_company(total_company):
    conn = cx_Oracle.connect("hr/hr@localhost:1521/xe")
    conn.encoding
    cursor = conn.cursor()
    sql = 'insert into company(company_num, coname, type, location, contact, text) values(company_seq.nextval,:coname,:type,:location,:contact,:text)'
    cursor.executemany(sql,total_company)
    conn.commit()

insert_company(total_company)
