import requests
from bs4 import BeautifulSoup
import datetime as dt
import sqlite3

conn = sqlite3.connect('zanieczyszczenia.db')

conn.execute("""
CREATE TABLE IF NOT EXISTS `zanieczyszczenia` (
    `ID`    INTEGER PRIMARY KEY AUTOINCREMENT,
    `PM10`    REAL,
    `PM25`    REAL,
    `O3`    REAL,
    `NO2`    REAL,
    `SO2`    REAL,
    `C6H6`    REAL,
    `data_odczytu`    TEXT
);
""")

SQL_DATE_FORMAT = '%Y-%m-%d %H:%M'

days = 30
pages = 50


def select_last_date():
    result = conn.execute("SELECT data_odczytu FROM zanieczyszczenia ORDER BY datetime(data_odczytu) DESC LIMIT 1").fetchone()
    if result is None or len(result) == 0:
        return dt.datetime.min
    else:
        return dt.datetime.strptime(result[0], SQL_DATE_FORMAT)

last_row_date = select_last_date()
now = dt.datetime.now() - dt.timedelta(hours=2)
for index in range(0, pages):
    url = 'http://powietrze.gios.gov.pl/pjp/current/station_details/table/550/' + str(days) + '/' + str(index)
    request = requests.get(url)
    html_content = request.text
    soup = BeautifulSoup(html_content, 'html.parser')

    html_table = soup.find('tbody')

    trs = html_table.find_all('tr')
    if len(trs) == 3:
        print('Seems like we don\'t have data on page: %d' % index)
        break

    for tr in trs:
        date = tr.find('th').string
        if date.find('i') != -1:
            continue
        else:
            # change date to sqlite format: 2007-01-01 10:00
            date = dt.datetime.strptime(date, '%d.%m.%Y, %H:%M')

            if now > date > last_row_date:
                print("Date %s does not exists. Insert to database" % date)
                values = []
                for td in tr.find_all('td'):
                    splited = td.string.split()
                    if len(splited) > 0:
                        values.append(float(splited[0].replace(',', '.')))
                    else:
                        values.append(None)

                # remove always empty CO column and put date
                values[-1] = date.strftime(SQL_DATE_FORMAT)
                conn.execute("""INSERT INTO zanieczyszczenia (PM10, PM25, O3, NO2, SO2, C6H6, data_odczytu)
                                                                       VALUES (?, ?, ?, ?, ?, ?, ?)""", values)
            else:
                print("Stop processing date: %s" % date)
print('Finish processing')
conn.commit()
conn.close()
