from enum import Enum

class ProvisioningStatus(Enum):
   'Provisioning statuses'
   Done = 'Done'
   Failed = 'Failed'
   Other = 'Other'

class HttpStatusReasons(Enum):
   'HTTP messages reasons'
   Unauthorized = 'The client application does not have permissions to call the API.'
   OkHealthz = 'This function app method is up & running'
   NotImplemented = 'This function app method is still being worked!'
   InternalServerError = 'An error ocurred, please check App Insights logs to get further information.'
