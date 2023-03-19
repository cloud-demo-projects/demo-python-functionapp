import logging
import azure.functions as func
from azure.identity import DefaultAzureCredential
from azure.storage.blob import BlobServiceClient
import json
import base64

def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')

    for header in req.headers:
        logging.info(f"header-{header}")

    if req.headers.get('X-MS-CLIENT-PRINCIPAL') != None:
        clientPrincipal = req.headers.get('X-MS-CLIENT-PRINCIPAL') # Extract client principal from header
        logging.info(f"clientPrincipal-{clientPrincipal}")
        cp = json.loads(base64.b64decode(clientPrincipal).decode('utf-8')) # Decode client principal
        logging.info(f"cp-{cp}")
        roles = [x['val'] for x in cp['claims'] if x['typ'] == 'roles'] # Extract claims from client principal
        logging.info(f"roles-{roles}")

        storage_account_name = "adls12133"
        default_credential = DefaultAzureCredential()
        blob_service_client = BlobServiceClient(account_url="{}://{}.blob.core.windows.net".format(
            "https", storage_account_name), credential=default_credential)

        # Create the container
        container_name = "siebel"
        container_client = blob_service_client.create_container(container_name)
        logging.info(container_client.container_name)

        return func.HttpResponse(f"{container_name} container created.", status_code=200)

    return func.HttpResponse(f"{container_name} request bypassed.", status_code=401)
