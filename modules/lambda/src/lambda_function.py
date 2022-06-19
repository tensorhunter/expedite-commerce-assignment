import os
import boto3
import json

ENDPOINT_NAME = os.environ['ENDPOINT_NAME']
runtime = boto3.client('runtime.sagemaker')

def lambda_handler(event, context):
    body = event['body']
    response = runtime.invoke_endpoint(EndpointName=ENDPOINT_NAME,
                                       ContentType='text/csv',
                                       Body=body)
    variant = response['InvokedProductionVariant']
    prediction = response['Body'].read().decode('utf-8').replace('\n','')
    return {
        'statusCode' : 200,
        'headers' : { 'Content-Type' : 'application/json', 'Access-Control-Allow-Origin' : '*' },
        'body' : json.dumps({'code': 200, 'variant': variant, 'prediction': prediction})
    }
