import pandas as pd

tab = []
i = 0
zm = 'Nr'
dfs = pd.read_html('http://powietrze.gios.gov.pl/pjp/current/station_details/table/550/30/1', header=0)
n=1

for d in dfs:
    print(d['Zanieczyszczenie'])
