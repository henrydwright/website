Title: How to set up the Azure FHIR Service
Date: 2024-07-27 18:38
Category: Blog
Tags: back-end,python,FHIR
Description: How to create Azure FHIR Service and connect with a Python script
Thumb_Image: default.jpg
Slug: fhir-blog-1-setting-up-the-azure-fhir-service

Annoyingly, the documentation on the Microsoft website for setting up and getting going with the FHIR service from scratch is not amazingly clear as the required information is spread across many pages.

For those of you who are Python enjoyers, here's a quick guide to getting to the point where you have a script that can read and write from your very own FHIR server. These instructions use the [Azure Portal](https://portal.azure.com/#home) approach throughout.

## 1. Create the FHIR service
Start by creating a new Resource Group for this project.

The FHIR service is part of the Azure Health Data Service product, so next you'll need to [create a Health Data Service workspace](https://learn.microsoft.com/en-us/azure/healthcare-apis/healthcare-apis-quickstart). Aside from FHIR, DICOM (imaging) and MedTech IoT services are also available.

Within your workspace you can now [create the FHIR service](https://learn.microsoft.com/en-us/azure/healthcare-apis/fhir/deploy-azure-portal). 

## 2. Create an app registration for client authentication
The FHIR service uses Microsoft Entra ID (formerly known as Azure Active Directory) for authentication.

You can authenticate in any way you like that Entra supports (e.g. as an individual user). For ease we'll use Client ID and Client Secret, so we need to create an app registration in Entra ID we can give the relevant permissions to.

To do this you need to:

1. Go to Microsoft Entra ID
2. Click on "App registrations" in the menu on the left (it may be under "Manage")
3. Click on "New registration"
4. Enter a name to identify your client by, and then click "Register"

Note down the "Application (client) ID" and the "Directory (tenant) ID" as you will need this in a moment.

Next, generate a client secret:

1. Click on "Certificates & secrets" in the menu on the left (it may be under "Manage")
2. Click on "New client secret"
3. Enter a description and create the secret

Copy and note down the secret value as you will need this in a moment.

Create a new folder for your project. Within this make a file called `.env` and within it enter the details you noted

    AUTH_CLIENT_SECRET=[CLIENT SECRET GOES HERE]
    AUTH_CLIENT_ID=[CLIENT ID GOES HERE]
    AUTH_TENANT_ID=[TENANT ID GOES HERE]

## 3. Give your app the right permissions
You now need to give your app permission to read and write from your FHIR server. 

1. Navigate to your FHIR service (NOT the Health Data Services workspace)
2. Click on "Access control (IAM)" on the left menu
3. Click on "Add role assignment"
4. Pick "FHIR Data Contributor" from the list (this gives full rights to the server)
5. Click "Next"
6. Click "+ Select members"
7. In the box enter the name of the App Registration you created earlier and select it
8. Click "Review + assign"

## 4. Install Python dependencies
In your project folder create a new virtualenv (to install modules for this project only)

    python -m venv .venv

Activate your newly created venv and then install modules for Entra ID authentication `azure-identity` and HTTP requests `requests`

    pip install azure-identity requests

## 5. Create Python script
We now need to do two things - authenticate to Entra ID and then interact with our server. The below script is an example of how to do both:

```python
import os

from azure.identity import ClientSecretCredential
import requests as r

# note: replace "healthservicesworkspacename" and "fhirservicename" with the names of your own items
FHIR_URL="https://healthservicesworkspacename-fhirservicename.fhir.azurehealthcareapis.com"

# load our secrets from the .env file
AUTH_TENANT_ID = os.environ["AUTH_TENANT_ID"]
AUTH_CLIENT_ID = os.environ["AUTH_CLIENT_ID"]
AUTH_CLIENT_SECRET = os.environ["AUTH_CLIENT_SECRET"]

# authenticate
creds = ClientSecretCredential(tenant_id=AUTH_TENANT_ID, client_id=AUTH_CLIENT_ID, client_secret=AUTH_CLIENT_SECRET)
tok = creds.get_token(f"{FHIR_URL}/.default", tenant_id=AUTH_TENANT_ID)

# do something with the server (in this case get all the Patients)
res = r.get(
    url=f"{FHIR_URL}/Patient",
    headers={
        "Authorization": f"Bearer {tok.token}"
    })

print(res.content)
```   

