import logging
import json
import base64

class AuthHelper():
  
def is_authorized(self, req, ignore_exp = False):
  
  for header in req.headers:
        logging.info(f"header-{header}")

    if req.headers.get('X-MS-CLIENT-PRINCIPAL') != None:
        clientPrincipal = req.headers.get('X-MS-CLIENT-PRINCIPAL') # Extract client principal from header
        logging.info(f"clientPrincipal-{clientPrincipal}")
        cp = json.loads(base64.b64decode(clientPrincipal).decode('utf-8')) # Decode client principal
        logging.info(f"cp-{cp}")
        roles = [x['val'] for x in cp['claims'] if x['typ'] == 'roles'] # Extract claims from client principal
        logging.info(f"roles-{roles}")
