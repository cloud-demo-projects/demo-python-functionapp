import unittest
import azure.functions as func
from container_create import main
import json


class Test_ContainerCreation(unittest.TestCase):
    def test_sample(self):
        self.assertEqual('foo'.upper(), 'FOO')

    def test_container_create(self):
        req = func.HttpRequest(
            method='POST',
            body=None,
            url='/api/storage/container')

        # resp = main(req)

        # self.assertEqual(
        #     resp.get_body(),
        #     json.dumps({'reason': 'UnAuthorized'}).encode(),
        # )


if __name__ == '__main__':
    unittest.main()
