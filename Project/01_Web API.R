## API Request

import requests

from requests import get

nums = list(range(1,50))

result = []

for i in nums:  
    url = f"https://rickandmortyapi.com/api/character/{i}"
    response = get(url)
    data_rickmorty = response.json()
    tables = [
        data_rickmorty["name"],
        data_rickmorty["status"],
        data_rickmorty["species"],
        data_rickmorty["gender"],
        data_rickmorty["origin"]
    ]
    result.append(tables)
    print(result)
   

print(result)

import pandas as pd

df = pd.DataFrame(result, columns=["name","status","species","gender","origin"])

df
