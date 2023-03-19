import logging
import azure.functions as func
import base64
import json
from azure.identity import DefaultAzureCredential
from azure.storage.blob import BlobServiceClient



def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processing a request.')

    # Authorization Checks
    try:
        for header in req.headers:
            logging.info(f"header-{header}")
        if req.headers.get('X-MS-CLIENT-PRINCIPAL') != None:
            clientPrincipal = req.headers.get('X-MS-CLIENT-PRINCIPAL') # Extract client principal from header
            logging.info(f"clientPrincipal-{clientPrincipal}")
            cp = json.loads(base64.b64decode(clientPrincipal).decode('utf-8')) # Decode client principal
            logging.info(f"cp-{cp}")
            roles = [x['val'] for x in cp['claims'] if x['typ'] == 'roles'] # Extract claims from client principal
            logging.info(f"roles-{roles}")

            if ('Data.Read' not in roles):  # Check whether required role claim is present to authorize the request
                return func.HttpResponse( "Not authorized",  status_code=401 )
        logging.info('Auth checks completed successfully')
    except Exception as e:
        logging.critical(e)

    # Creating container
    storage_account_name = "adls12133"
    container_name = "siebel"
    default_credential = DefaultAzureCredential()
    blob_service_client = BlobServiceClient(account_url="{}://{}.blob.core.windows.net".format(
                                "https", storage_account_name), credential=default_credential)

    container_client = blob_service_client.create_container(container_name)
    logging.info(f"container created:-{container_client.container_name}")

    return func.HttpResponse( "Success with auth",  status_code=200 )
