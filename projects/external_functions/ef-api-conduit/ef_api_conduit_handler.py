import json
import requests

def call_api(api_endpoint, api_method, api_headers, api_payload):
    # Make the API call using the requests library
    response = requests.request(api_method, api_endpoint, headers=api_headers, json=api_payload)
    
    # Construct the response object to be returned by the Lambda function
    response_object = {
        'statusCode': response.status_code,
        'headers': dict(response.headers),
        'body': response.text
    }
    
    return {
        'statusCode': 200,
        'headers': {
            'Content-Type': 'application/json'
        },
        'body': json.dumps(response_object)
    }



def handle(event, context):
    # Parse the JSON object passed in by the API Gateway
    print(event)
    request_data = json.loads(str(event['body']))
    
    # Extract the details for the API call from the JSON object
    api_endpoint = request_data.get('endpoint')
    api_method   = request_data.get('method', 'GET') # default to get method
    api_headers  = request_data.get('headers', '')   # default to no headers
    api_payload  = request_data.get('payload', '')   # default to no payload

    print(f"""
      api_endpoint = {api_endpoint}
      api_method   = {api_method}
      api_headers  = {api_headers}
      api_payload  = {api_payload}
    """)

    # resp = call_api(api_endpoint, api_method, api_headers, api_payload)

    body = {
        "message": "not bad!",
        "input": event,
    }

    response = {"statusCode": 200, "body": json.dumps(body)}

    return response
