# %%
import requests

import pandas as pd

# %%
lat = 27.988073124741003
lon = 86.92497958336114
API_key = "ba8fc0c7c0af9f0c2a2e114fc9850623" #doplnit vlastní


url = f"https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API_key}&units=metric"
vysledek = requests.get(url)

# %%
vysledek_dict = vysledek.json()
everest = pd.DataFrame.from_records([vysledek_dict["main"]])
everest

# %%
mesta = ["Praha", "Brno", "Ostrava", "Cairo", "Barcelona", "Madrid", "Toronto", "Talin", "Stockholm"]

vysledky = pd.DataFrame()
for city_name in mesta:
    url = f"https://api.openweathermap.org/data/2.5/weather?q={city_name}&appid={API_key}&units=metric"
    vysledek = requests.get(url)
    vysledek_dict = vysledek.json()
    vysledek_dict["main"]["mesto"] = city_name
    radek = pd.DataFrame.from_records([vysledek_dict["main"]]).set_index("mesto")
    vysledky = pd.concat([vysledky, radek])

# %%
vysledky


