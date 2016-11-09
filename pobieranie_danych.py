import pandas as pd

tab = []
i = 0
zm = 'Nr'
dfs = pd.read_html('http://powietrze.gios.gov.pl/pjp/current/station_details/table/550/30/1', header=0,encoding=str)
n=1

for d in dfs:
    print(d)


 #   for i in range(10):
#        tab.append([ ])
 #   for j in range(10):
  #      tab[j].append(d['PM10'][j])


#print(tab)
#print(tab[1][1])