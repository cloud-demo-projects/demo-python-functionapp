
import json
import azure.functions as func


def main(req: func.HttpRequest) -> str:
      
    return func.HttpResponse(json.dumps({ 'reason' : 'functionapp is up & running!' }), mimetype="application/json",status_code=200)

