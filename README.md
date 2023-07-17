# Demo Python Functionapp
Python functionapp with IaC(bicep), CICD, Azure AD Authentication & Authorization, Unit tests, Azure SQL interaction and Open API.

![image](https://github.com/cloud-demo-projects/demo-python-functionapp/assets/67367858/081ff259-16e9-402f-bb91-4be89f9f4089)


# CICD
[![Build Status](https://dev.azure.com/bahrinipun/demo-python-functionapp/_apis/build/status/python-functionapp-cicd?branchName=main)](https://dev.azure.com/bahrinipun/demo-python-functionapp/_build/latest?definitionId=93&branchName=main)

# Features

## OpenAPI Integration
Open API invocation to retrieve information.

## FunctionApp authentication & authorization using Azure AD frontend and client application
![image](https://user-images.githubusercontent.com/67367858/226348155-41b179d5-8c22-4ef6-a0e9-6c45fa2089b6.png)

## Unit Testing
python -m unittest .\tests\test_container_create.py

## Azure SQL 
- Database server creation with functionapp-SQL network whitelisting and SPN as databaserver admin
- Database and schema ceation
- Database role, contained users(MSI and Engineers) and permissions creation
- Database tables creation

## Pre-Commit Hook
- pip install pre-commit
- pre-commit sample-config > .pre-commit-config.yaml
- pre-commit install
- Works now with both "got commit" and VS code commits as shown below-
  ![image](https://github.com/cloud-demo-projects/demo-python-functionapp/assets/67367858/338395f5-684b-47c3-aa3c-196d07f78636)

