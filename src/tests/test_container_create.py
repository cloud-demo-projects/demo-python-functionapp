import unittest
import azure.functions as func
from container_create import main, run
import json
from shared.enums.enums import HttpStatusReasons
from shared.helpers.auth_helper import AuthHelper


auth_helper = AuthHelper()

class Test_ContainerCreation(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        print("Start testing")
        cls.credential = auth_helper.get_credentials()

    @classmethod
    def tearDownClass(cls):
        print('Cleaning Up')

    def setUp(self):
        self.url = '/api/container_create'
        self.method = 'POST'
        self.req_file = open('container_create/sample-request.json')

    def tearDown(self):
        self.url = ''
        self.method = ''
        self.req_file.close()

    # Testing without Auth
    def test_authentication_invalid(self):
        req = func.HttpRequest(
                method = self.method,
                body=None,
                url=self.url)

        resp = main(req)

        self.assertEqual(
                resp.get_body(),
                json.dumps({ 'reason' : HttpStatusReasons.Unauthorized.value }).encode(),
        )

    # Testing for invalid params
    def test_params_validation_invalid(self):

        req_body = json.dumps(json.load(self.req_file)).encode('utf-8')
        req = func.HttpRequest(
                method = self.method,
                body=req_body,
                url=self.url,
                params={"test":"failed"})

        resp = run(req)

        self.assertEqual(resp.status_code, 400)


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
