import unittest
import json
import azure.functions as func
from healthz import main

class TestEnum(unittest.TestCase):
    def test_function_healthz_main(self):
        req = func.HttpRequest(
            method='GET',
            body=None,
            url='/api/v1/healthz')

        resp = main(req)

        self.assertEqual(
            resp.get_body(),
            json.dumps({ 'reason' : 'functionapp is up & running!' }).encode(),
        )
