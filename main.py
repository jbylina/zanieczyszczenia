import requests
from bs4 import BeautifulSoup
import numpy as np
import sqlite3

conn = sqlite3.connect('zanieczyszczenia2.db')

conn.execute("""
CREATE TABLE IF NOT EXISTS `zanieczyszczenia` (
	`ID`	INTEGER PRIMARY KEY AUTOINCREMENT,
	`PM10`	REAL,
	`PM25`	REAL,
	`O3`	REAL,
	`NO2`	REAL,
	`SO2`	REAL,
	`C6H6`	REAL,
	`data_odczytu`	text
);
""")

days = 15
pages =3
index_kolumny=0
tab_string = []
liczba_petli=0;
ll=48
for index in range(0, pages):

    url = 'http://powietrze.gios.gov.pl/pjp/current/station_details/table/550/' + str(days) + '/' + str(index)
    request = requests.get(url)
    html_content = request.text
    soup = BeautifulSoup(html_content, 'html.parser')

    html_table = soup.find('tbody')
    for tr in html_table.find_all('tr'):
        date = tr.find('th').string
        date=date.replace(" ","")
        date=date.replace(",","")
        date=date.replace(":","")
        date=date.replace(".","")
        date=date.replace("Minimum","1")
        date=date.replace("Maksimum","1")
        date=date.replace("Średnia","1")
        values = []
        for td in tr.find_all('td'):
            splited = td.string.split()
            if len(splited) > 0:
                values.append(float(splited[0].replace(',', '.')))
        # index_kolumny=index_kolumny+1
        conn.execute("""INSERT INTO zanieczyszczenia (PM10, PM25, O3, NO2, SO2, C6H6, data_odczytu)
                                               VALUES ({PM10}, {PM25}, {O3}, {NO2}, {SO2}, {C6H6}, {data_odczytu})""". \
            format(PM10=values[0], PM25=values[1], O3=values[2], NO2=values[3], SO2=values[4], C6H6=values[5], data_odczytu=date))
        conn.commit()
    # print(index_kolumny)

    # conn.execute("DELETE  From zanieczyszczenia WHERE ID ="+str(i))
    # conn.execute("delete from zanieczyszczenia where rowid IN (SELECT rowid from zanieczyszczenia limit 3 offset "+str(ll)+")")
    conn.execute("Delete from zanieczyszczenia where data_odczytu =1")
    conn.commit()
    # liczba_petli=liczba_petli+1;
    # ll=ll+48




#
