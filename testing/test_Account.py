from unittest import TestCase
from Account import Account


class TestAccount(TestCase):

    def setUp(self):
        self.acc = Account("Michal")

    def test_init_balance(self):
        self.assertEqual(self.acc.balance, 0)

    def test_change_amount(self):
        self.acc.change_account_balance(2000)
        self.acc.change_account_balance(-500)
        self.assertEqual(self.acc.balance, 1500)

    def test_below_zero(self):
        with self.assertRaises(ValueError) as exception_context:
            self.acc.change_account_balance(2000)
            self.acc.change_account_balance(-5000)
        self.assertIn("Not enough money", str(exception_context.exception))
