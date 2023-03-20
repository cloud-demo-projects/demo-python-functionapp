import logging
import azure.functions as func
from azure.identity import DefaultAzureCredential
from azure.storage.blob import BlobServiceClient
from shared.helpers.log_helper import LogHelper
from shared.helpers.auth_helper import AuthHelper
from shared.models.request_payload import CoreProducer 
import json
import base64
import os
import uuid

# Global Variables
STORAGE_ACCOUNT = os.environ.get('STORAGE_ACCOUNT')
BAD_REQUEST_MESSAGE = "Function execution finished with status 400 (Bad Request)"

RUN_ID = str(uuid.uuid4()) 
log_helper = LogHelper(RUN_ID)
auth_helper = AuthHelper()

def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')
    
    if (not auth_helper.is_authorized(req)):
        log_helper.log_error("Unthorized execution attempt")
        return func.HttpResponse(json.dumps({ 'reason' : HttpStatusReasons.Unauthorized.value }), mimetype="application/json",status_code=401)
    
    return run(req)
    
def run(req: func.HttpRequest) -> str:
    log_helper.log_info("Run function execution started")
    
    # clientside validations
    try:
        req_body = req.get_json()
        producer: CoreProducer = CoreProducer(**req_body)
        log_helper.log_info("Finished payload validation, valid payload")
        log_helper.log_info(f"Request body: {req_body}")
    except ValueError as e:
        log_helper.log_error(f"{e}")
        log_helper.log_error(BAD_REQUEST_MESSAGE)
        return func.HttpResponse(str(e), status_code=400) 
    except ValidationError as e:
        log_helper.log_error(f"{e}")
        log_helper.log_error(BAD_REQUEST_MESSAGE)
        return func.HttpResponse(e.json(), status_code=400)
    

    storage_account_name = "adls12133"
    # default_credential = DefaultAzureCredential()
    default_credential = auth_helper.get_credentials()
    blob_service_client = BlobServiceClient(account_url="{}://{}.blob.core.windows.net".format(
        "https", storage_account_name), credential=default_credential)

    # Create the container
    container_name = "siebel"
    try:
        container_client = blob_service_client.create_container(container_name)
        logging.info(container_client.container_name)
    except Exception as e:
        log_helper.log_error(f"{e}")
    finally:
        blob_service_client.close()
    
    log_helper.log_info(f"Finished container creation- {container_name}")
    return func.HttpResponse(f"{container_name} container created.", status_code=200)
