class Account:

    def __init__(self, owner):
        self.owner = owner
        self.balance = 0

    def get_balance(self):
        print(self.balance)

    def change_account_balance(self, amount):
        if self.balance + amount >= 0:
            self.balance += amount
            return self.balance
        else:
            raise ValueError("Not enough money on account!")
