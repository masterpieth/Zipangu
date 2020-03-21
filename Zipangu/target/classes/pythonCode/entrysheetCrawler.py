from selenium import webdriver
from urllib.request import urlopen
from bs4 import BeautifulSoup
from selenium.webdriver.common.keys import Keys
import cx_Oracle
import os
os.environ['NLS_LANG'] = '.UTF8'

path = 'C:\webdriver\chromedriver'
driver = webdriver.Chrome(path)
login_url = 'https://job.rikunabi.com/2021/auth/topLoginform/?toplocationUrl=&topPattern=top&sslMode=1&menu=t&isc=r21rcna01556&toplink=pagetop'
driver.get(login_url)
id = 'wronggim'
pwd = 'rik2020wro'
elem = driver.find_element_by_name('rikunabiCd')
elem.send_keys(id)
elem = driver.find_element_by_name('password')
elem.send_keys(pwd)
elem.send_keys(Keys.RETURN)
entrysheet_mainurl = 'https://job.rikunabi.com/2021/contents/article/edit~es_senior~index/u/?isc=r21rcnz00228'
driver.get(entrysheet_mainurl)

index_list = []
num = 1
while num <= 7:
    index = driver.find_elements_by_xpath('//*[@id="senior_index"]/li['+str(num)+']/a')
    index_list.append(index)
    num = num +1

index_url = []
for index in index_list:
    index_url.append(index[0].get_attribute('href'))

link_list = []
link_url = []
for url in index_url:
    driver.get(url)
    html = driver.page_source
    soup = BeautifulSoup(html, 'html.parser')
    h2 = soup.findAll('h2',{'class':'ttl_senior_01'})
    maxnum = len(h2)
    startnum = 1
    while startnum <= maxnum:
        link = driver.find_elements_by_xpath('//*[@id="senior_links"]/li['+str(startnum)+']/a')
        link_url.append(link[0].get_attribute('href'))
        startnum = startnum + 1

total_person = []
for link in link_url:
    driver.get(link)
    html = driver.page_source
    soup = BeautifulSoup(html, 'html.parser')

    person = ['','','','','','','','','']
    dl = soup.findAll('dl',{'class':'dl_senior'})
    for data in dl:
        if data.dt.text == '保有資格':
            person[3] = data.dd.text
        elif data.dt.text == '趣味・特技':
            person[4] = data.dd.text
        elif data.dt.text == '学業、ゼミ、研究室などで取り組んだ内容':
            person[5] = data.dd.text
        elif data.dt.text == '自己PRなど':
            person[6] = data.dd.text
        elif data.dt.text == '学生時代に最も打ち込んだこと':
            person[7] = data.dd.text
        elif data.dt.text == '先輩からのアドバイス':
            person[8] = data.dd.text
        
    div = soup.find('div',{'class':'detail_box'})
    li = soup.select('.detail_box li')
    li_text = []
    for text in li:
        li_text.append(text.text)
    
    li_text[0] = li_text[0].replace('業種：','')
    li_text[1] = li_text[1].replace('規模：','')
    li_text[2] = li_text[2].replace('エリア：','')
    person[0] = li_text[0]
    person[1] = li_text[1]
    person[2] = li_text[2]
    
    for data in person:
        data = data.encode('utf-8')

    person_tuple = (person[0],person[1],person[2],person[3],person[4],person[5],person[6],person[7],person[8])
    total_person.append(person_tuple)

def insert_entrysheet(total_person):
    conn = cx_Oracle.connect("hr/hr@localhost:1521/xe")
    conn.encoding
    cursor = conn.cursor()
    sql = 'insert into entrysheet(entrysheet_num,jobtype,comsize,comlocation,qualification,hobbynskill,study,pr,absorption,advice) values (entrysheet_seq.nextval,:jobtype,:comsize,:comlocation,:qualification,:hobbynskill,:study,:pr,:absorption,:advice)'
    cursor.executemany(sql,total_person)
    conn.commit()

insert_entrysheet(total_person)
