from random import randint

class Postava:

  def __init__(self, jmeno, zivoty=100, utok_min=5, utok_max=10, stit=2):
    self.jmeno = jmeno
    self.zivoty = zivoty
    self.mrtev = False
    self.utok_min = utok_min
    self.utok_max = utok_max
    self.stit = stit

  def ukaz_zivoty(self):
    print(f"{self.jmeno} má {self.zivoty} životů!")

  def utok(self):
    return randint(self.utok_min, self.utok_max)

  def obrana(self, rana):
    # kontrola, jestli útok je dost silný, aby prošel štítem
    if rana > self.stit:
      # upravit životy -> zmenšit útok o štít a odečíst životy
      self.zivoty = self.zivoty - (rana - self.stit)
      # kontrola, pokud po provedené obraně neumřela postava
      if self.zivoty < 1:
        # pokud ano přenastavit atribut mrtev
        self.mrtev = True

class Carodej(Postava):

  def utok(self):
    # původní útok Postavy -> přes super() zavolám metodu rodiče
    utok = super().utok()
    # los -> prvek náhody
    los = randint(1, 10)
    if los < 4:
      # nízké číslo -> útok neměním
      return utok
    elif los < 7:
      return utok * 3
    elif los < 10:
      return utok * 5
    else:
      return utok * 10