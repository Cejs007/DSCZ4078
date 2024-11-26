# %% [markdown]
# ### Vytvořit DB

# %%
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, Integer, String

from sqlalchemy import create_engine

from sqlalchemy.orm import sessionmaker

import pandas as pd
from faker import Faker
from random import randint

# %%
# base for table classes
Base = declarative_base()

# pripojeni
engine = create_engine('mysql+pymysql://pacient_admin:DSCZ4078@localhost/projektpacienti')

Session = sessionmaker(bind=engine)
link = Session()

# %% [markdown]
# ### Tabulka pacienti -> id, jmeno, prijmeni, vek

# %%
# sample class mapping table from database
class Pacient(Base):

   __tablename__ = 'pacienti'

   # fields and their types
   id = Column(Integer, primary_key=True, autoincrement=True)
   jmeno = Column(String(40))
   prijmeni = Column(String(40))
   vek = Column(Integer)

   def __init__(self, jmeno, prijmeni, vek):
      self.jmeno = jmeno
      self.prijmeni = prijmeni
      self.vek = vek


# %% [markdown]
# ### Tabulka zdravotni_udaje -> výška, hmotnost, krevní skupina

# %%
# sample class mapping table from database
class ZdravotniUdaj(Base):
    
    __tablename__ = 'zdravotni_udaj'

    # fields and their types
    id = Column(Integer, primary_key=True, autoincrement=True)
    vyska = Column(Integer)
    hmotnost = Column(Integer)
    krevni_skupina = Column(String(40))

    def __init__(self, vyska, hmotnost, krevni_skupina):
        self.vyska = vyska
        self.hmotnost = hmotnost
        self.krevni_skupina = krevni_skupina

# %% [markdown]
# ### Tabulka platebni_udaje -> cislo_karty, cislo_uctu, banka

# %%
# sample class mapping table from database
class PlatebniUdaj(Base):

   __tablename__ = 'platebni_udaj'

   # fields and their types
   id = Column(Integer, primary_key=True, autoincrement=True)
   platebni_karta = Column(Integer)
   cislo_uctu = Column(Integer)
   banka = Column(String(40))

   def __init__(self, platebni_karta, cislo_uctu, banka):
      self.platebni_karta = platebni_karta
      self.cislo_uctu = cislo_uctu
      self.banka = banka

# %%
Base.metadata.create_all(engine)

# %% [markdown]
# ### Generování náhodných lidí s údaji

# %%
fake = Faker('cs_CZ')
lidi = []
zdravotni = []
platebni = []

krevni_skupiny = {0: "0", 1: "A", 2: "B", 3: "AB"}
banky = {0: "CSOB", 1: "KB", 2: "AirBank", 3: "Moneta", 4: "Fio"}

objekty = {}

for i in range(10):
    clovek = {"jmeno": fake.first_name(), "prijmeni": fake.last_name(), "vek": randint(0, 100)}
    zdr = {"vyska": randint(150, 200), "hmotnost": randint(45, 150), "krevni_skupina": krevni_skupiny[randint(0, 3)]}
    plat = {"platebni_karta": fake.credit_card_number(), "cislo_uctu": fake.passport_number(), "banka": banky[randint(0, 4)]}
    # příprava na dfs
    lidi.append(clovek)
    zdravotni.append(zdr)
    platebni.append(plat)
    # vytvářet objekty pro ORM
    objekty[i] = Pacient(clovek["jmeno"], clovek["prijmeni"], clovek["vek"])

# %%
lidi_df = pd.DataFrame.from_records(lidi)
lidi_df

# %%
zdravotni_df = pd.DataFrame.from_records(zdravotni)
zdravotni_df

# %%
platebni_df = pd.DataFrame.from_records(platebni)
platebni_df

# %%
lidi_df.to_sql(name='pacienti', con=engine, if_exists='replace', index=False)

# %%
platebni_df

# %% [markdown]
# ### Uložení dat do databáze

# %%
for key, novy_pacient in objekty.items():
    link.add(novy_pacient)

# %%
id001 = Pacient('Michal', "Maliszewski", 32)
link.add(id001)

# %%
pu001 = PlatebniUdaj(12345, 54321, "CSOB")
link.add(pu001)

# %%
zu001 = ZdravotniUdaj(187, 95, "AB")
link.add(zu001)

# %%
# provést změny na databázi
link.commit()


