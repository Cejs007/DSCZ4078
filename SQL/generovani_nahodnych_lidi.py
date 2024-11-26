# %%
import pandas as pd
from faker import Faker
from random import randint

# %%
fake = Faker('cs_CZ')
lidi = []
adresy = []
for i in range(10):
    clovek = {"rodne_cislo": fake.birth_number(), "jmeno": fake.first_name(), "prijmeni": fake.last_name(), "vek": randint(0, 100), "adresa_id": i}
    adresa = {"adresa_id": i, "mesto": fake.city(), "adresa": fake.street_address()}
    lidi.append(clovek)
    adresy.append(adresa)

# %%
lidi_df = pd.DataFrame.from_records(lidi)
lidi_df["rodne_cislo"] = lidi_df["rodne_cislo"].apply(lambda rc: rc.replace("/", ""))
lidi_df["rodne_cislo"] = lidi_df["rodne_cislo"].astype(int)
lidi_df

# %%
adresy_df = pd.DataFrame.from_records(adresy)
adresy_df

# %%
lidi_df.merge(adresy_df, left_on="adresa_id", right_on="adresa_id")

# %%
lidi_df.to_csv("lidi.csv", index=False)
adresy_df.to_csv("adresy.csv", index=False)


