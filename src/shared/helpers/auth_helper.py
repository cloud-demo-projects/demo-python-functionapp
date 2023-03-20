import logging
import json
import base64

class AuthHelper():
  
def get_credentials(self) -> DefaultAzureCredential:
  ''' Acquire a credential object for the app identity. 
  When running on Azure: DefaultAzureCredential uses the app's managed identity (MSI) or user-assigned service principal.
  When running on your a local host: DefaultAzureCredential relies on environment variables named AZURE_CLIENT_ID, AZURE_CLIENT_SECRET, and AZURE_TENANT_ID. 

  Create your own SPN for local development and add these values to you local.settings.json
  https://docs.microsoft.com/en-gb/cli/azure/create-an-azure-service-principal-azure-cli'''

  return DefaultAzureCredential()
  
def is_authorized(self, req, ignore_exp = False):
  
  for header in req.headers:
    logging.info(f"header-{header}")
      
  auth_header = req.headers.get('Authorization')
  if not auth_header:
    logging.error("Authorization header Not found in the request")
    return False

  if auth_header.get('X-MS-CLIENT-PRINCIPAL') != None:
    clientPrincipal = req.headers.get('X-MS-CLIENT-PRINCIPAL') # Extract client principal from header
    logging.info(f"clientPrincipal-{clientPrincipal}")
    cp = json.loads(base64.b64decode(clientPrincipal).decode('utf-8')) # Decode client principal
    logging.info(f"cp-{cp}")
    roles = [x['val'] for x in cp['claims'] if x['typ'] == 'roles'] # Extract claims from client principal
    logging.info(f"roles-{roles}")
