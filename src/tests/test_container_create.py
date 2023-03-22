import unittest
import azure.functions as func
from container_create import main
import json
from shared.enums.enums import HttpStatusReasons


class Test_ContainerCreation(unittest.TestCase):

    def test_container_create(self):
        req = func.HttpRequest(
            method='POST',
            body=None,
            url='/api/container_create')

        resp = main(req)

        self.assertEqual(
            resp.get_body(),
            json.dumps({'reason': HttpStatusReasons.Unauthorized.value}).encode(),
        )


if __name__ == '__main__':
    unittest.main()
