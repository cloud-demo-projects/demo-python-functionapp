from typing import Optional
from pydantic import BaseModel, validator, constr
from uuid import UUID
import os
import re
from json import JSONEncoder

class CoreProducer(BaseModel): 
  StorageAccountName: str
  ContainerName: str
  VnetRules: Optional[list[Network]]
