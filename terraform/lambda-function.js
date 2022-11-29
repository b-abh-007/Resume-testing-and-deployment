"use strict";

const AWS = require("aws-sdk");
AWS.config.update({ region: "me-central-1" });

const docClient = new AWS.DynamoDB.DocumentClient();

exports.handler = async (event) => {
  await docClient
    .update({
      TableName: "visitor-counter-table-2.0",
      Key: {
        "visitor-counter": "counter",
      },
      UpdateExpression: "set #num = #num + :incr",
      ExpressionAttributeNames: {
        "#num": "number",
      },
      ExpressionAttributeValues: {
        ":incr": 1,
      },
    })
    .promise();

  var visitorCount = await docClient
    .get({
      Key: {
        "visitor-counter": "counter",
      },
      TableName: "visitor-counter-table-2.0",
      AttributesToGet: ["number"],
    })
    .promise();
  const headers = {
    "Content-Type": "application/json",
    "Access-Control-Allow-Headers":
      "Content-Type,X-Amz-Date,X-Amz-Security-Token,Authorization,X-Api-Key,X-Requested-With,Accept,Access-Control-Allow-Methods,Access-Control-Allow-Origin,Access-Control-Allow-Headers",
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Methods": "*",
    "X-Requested-With": "*",
  };
  return {
    statusCode: 200,
    body: JSON.stringify(visitorCount.Item.number),
    headers,
  };
};
