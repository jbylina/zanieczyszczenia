import requests
from bs4 import BeautifulSoup
import numpy as np
import matplotlib.pyplot as plt


days = 9
pages = 5
tab_string = []
tab_data=[]

for index in range(0, pages):
    url = 'http://powietrze.gios.gov.pl/pjp/current/station_details/table/550/' + str(days) + '/' + str(index)
    request = requests.get(url)
    html_content = request.text
    soup = BeautifulSoup(html_content, 'html.parser')
    for td in soup.find_all('td'):
        tab_string.extend(td.string.split())
    del tab_string[-18:]   #delete min, max, avg
    for th in soup.find_all('th'):
        tab_data.extend(th)
    del tab_data[1:15]

print(tab_data)
vector_float = np.array([])

for element_string in tab_string:
    element_float = float(element_string.replace(',','.'))
    vector_float = np.append(vector_float, element_float)


row = 0
column = 0
number_of_rows = vector_float.size/6
table = np.zeros((number_of_rows, 6))

for element in vector_float:
    table[row][column] = element
    column = column + 1
    if column%6 == 0:
        column = 0
        row = row + 1

#print(table)
# Ox = np.arange(1, number_of_rows +1)

# plt.plot(Ox, table[0:number_of_rows, 0], 'r-', label='PM10')
# plt.plot(Ox, table[0:number_of_rows, 1], 'g-', label='PM2.5')
# plt.plot(Ox, table[0:number_of_rows, 2], 'b-', label='O3')
# plt.plot(Ox, table[0:number_of_rows, 3], 'r--', label='NO2')
# plt.plot(Ox, table[0:number_of_rows, 4], 'g--', label='SO2')
# plt.plot(Ox, table[0:number_of_rows, 5], 'b--', label='C6H6')
#
# plt.xlabel('Godziny')
# plt.ylabel('Wartości')
# plt.grid()
# plt.legend()
#
# plt.show()
#