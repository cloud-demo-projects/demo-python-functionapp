import unittest

class TestContainerCreation(unittest.TestCase):
    def TestContainerCreate(self):
        self.assertEqual('foo'.upper(),'FOO')


if __name__ == '__main__':
    unittest.main()