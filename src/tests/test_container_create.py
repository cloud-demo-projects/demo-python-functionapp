import unittest


class Test_ContainerCreation(unittest.TestCase):
    def test_container_create(self):
        self.assertEqual('foo'.upper(), 'FOO')


if __name__ == '__main__':
    unittest.main()
