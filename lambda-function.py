import boto3
import json
dynamodb = boto3.client('dynamodb')
headers = {
    "Access-Control-Allow-Headers":
    "Content-Type,X-Amz-Date,X-Amz-Security-Token,Authorization,X-Api-Key,X-Requested-With,Accept,Access-Control-Allow-Methods,Access-Control-Allow-Origin,Access-Control-Allow-Headers",
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Methods": "*",
    "X-Requested-With": "*",
}

def handler(event, context):
    try:
        func = dynamodb.update_item(
            TableName="visitor-counter-table-2.0",
            Key={
                'visitor-counter': {
                    "S": "resume-counter"
                }
            },
            # UpdateExpression="set number = number + 1",
            UpdateExpression="set #num = #num + :incr",
            ExpressionAttributeNames={
                "#num": "number",
            },
            ExpressionAttributeValues={
                ':incr': {
                    'N': "1"
                }
            },
        )

        number = dynamodb.get_item(
            TableName="visitor-counter-table-2.0",
            Key={
                'visitor-counter': {
                    "S": "resume-counter"
                }
            },

            AttributesToGet=[
                "number"
            ],
        )
    except ClientError as err:
        raise

    return response()

def response():
    return {
        'statusCode': 200,
        'body': "bodyy",
        'headers': {
            "Access-Control-Allow-Headers":
            "Content-Type,X-Amz-Date,X-Amz-Security-Token,Authorization,X-Api-Key,X-Requested-With,Accept,Access-Control-Allow-Methods,Access-Control-Allow-Origin,Access-Control-Allow-Headers",
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Methods": "*",
            "X-Requested-With": "*",
        },
    }
