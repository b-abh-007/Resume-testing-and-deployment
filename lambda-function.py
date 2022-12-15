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


def run():
    try:
        response = dynamodb.update_item(
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
    except ClientError as err:
        logger.error(
            "ErrorTest1234",
            err.response['Error']['Code'], err.response['Error']['Message'])
        raise
    else:
        return response({'message': "msg"})


def run2(start_response):
    try:
        response2 = dynamodb.get_item(
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
    else:
        return response({'message': "msg"})


def response(message, status_code):
    return {
        'statusCode': 200,
        'body': json.stringify(visitorCount.Item.number),
        'headers': {
            "Access-Control-Allow-Headers":
            "Content-Type,X-Amz-Date,X-Amz-Security-Token,Authorization,X-Api-Key,X-Requested-With,Accept,Access-Control-Allow-Methods,Access-Control-Allow-Origin,Access-Control-Allow-Headers",
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Methods": "*",
            "X-Requested-With": "*",
        },
    }
