# Demo Python Functionapp
Python functionapp with IaC(bicep), CICD, Azure AD Authentication & Authorization, Unit tests and Azure SQL interaction.

# CICD
[![Build Status](https://dev.azure.com/bahrinipun/demo-python-functionapp/_apis/build/status/python-functionapp-cicd?branchName=main)](https://dev.azure.com/bahrinipun/demo-python-functionapp/_build/latest?definitionId=93&branchName=main)

# Features
## FunctionApp authentication & authorization using Azure AD frontend and client application
![image](https://user-images.githubusercontent.com/67367858/226348155-41b179d5-8c22-4ef6-a0e9-6c45fa2089b6.png)


![image](https://user-images.githubusercontent.com/67367858/226169287-8b3d4444-5ee3-4ea1-a32f-d8c0e97fc54e.png)

## Unit Testing
python -m unittest .\tests\test_container_create.py

## Azure SQL 
- Database server creation with functionapp-SQL network whitelisting and SPN as databaserver admin
- Database and schema ceation
- Database role, contained users(MSI and Engineers) and permissions creation
- Database tables creation
