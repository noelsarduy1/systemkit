import boto3
import logging
from boto3.dynamodb.conditions import Key, Attr

from botocore.exceptions import ClientError

def create_table(dynamodb):

    # Create the DynamoDB table.
    try:
        table = dynamodb.create_table(
            TableName='users',
            KeySchema=[
                {
                    'AttributeName': 'username',
                    'KeyType': 'HASH'
                },
                {
                    'AttributeName': 'last_name',
                    'KeyType': 'RANGE'
                }
            ],
            AttributeDefinitions=[
                {
                    'AttributeName': 'username',
                    'AttributeType': 'S'
                },
                {
                    'AttributeName': 'last_name',
                    'AttributeType': 'S'
                },
            ],
            ProvisionedThroughput={
                'ReadCapacityUnits': 5,
                'WriteCapacityUnits': 5
            }
        )

        # Wait until the table exists.
        table.meta.client.get_waiter('table_exists').wait(TableName='users')

        # Print out some data about the table.
        print(table.item_count)

    except dynamodb.exceptions.ResourceInUseException:
        print("table already exists")
        logging.error("Exception occurred", exc_info=True)
    pass


def create_new_item(table):

    try:
        table.put_item(
           Item={
                'username': 'janedoe',
                'first_name': 'Jane',
                'last_name': 'Doe',
                'age': 25,
                'account_type': 'standard_user',
            }
        )
    except ClientError as e:
        if e.response['Error']['Code'] == 'EntityAlreadyExists':
            print("User already exists")
        else:
            print("Unexpected error: %s" % e)

def getting_item(table):

    try:
        response = table.get_item(
            Key={
                'username': 'janedoe',
                'last_name': 'Doe'
            }
        )
    except ClientError as e:
        print("exception")
        print(e.response['Error']['Message'])
    else:
        print('response: ', response)
        item = response['Item']
        print(item)

def updating_item(table):
    table.update_item(
        Key={
            'username': 'janedoe',
            'last_name': 'Doe'
        },
        UpdateExpression='SET age = :val1',
        ExpressionAttributeValues={
            ':val1': 26
        }
    )
    response = table.get_item(
        Key={
            'username': 'janedoe',
            'last_name': 'Doe'
        }
    )
    item = response['Item']
    print(item)

def deleting_item(table):
    try:
        response = table.delete_item(
            Key={
                'username': 'janedoe',
                'last_name': 'Doe'
            },
            # Conditional request
            ConditionExpression="age <= :value",
            ExpressionAttributeValues={
                ":value": 26
            }
        )
    except ClientError as er:
        if er.response['Error']['Code'] == "ConditionalCheckFailedException":
            print(er.response['Error']['Message'])
            logging.error("Exception occurred", exc_info=True)
        else:
            raise
    else:
        return response


def batch_writing(table):

    with table.batch_writer() as batch:
        batch.put_item(
            Item={
                'account_type': 'standard_user',
                'username': 'johndoe',
                'first_name': 'John',
                'last_name': 'Doe',
                'age': 25,
                'address': {
                    'road': '1 Jefferson Street',
                    'city': 'Los Angeles',
                    'state': 'CA',
                    'zipcode': 90001
                }
            }
        )
        batch.put_item(
            Item={
                'account_type': 'super_user',
                'username': 'janedoering',
                'first_name': 'Jane',
                'last_name': 'Doering',
                'age': 40,
                'address': {
                    'road': '2 Washington Avenue',
                    'city': 'Seattle',
                    'state': 'WA',
                    'zipcode': 98109
                }
            }
        )
        batch.put_item(
            Item={
                'account_type': 'standard_user',
                'username': 'bobsmith',
                'first_name': 'Bob',
                'last_name':  'Smith',
                'age': 18,
                'address': {
                    'road': '3 Madison Lane',
                    'city': 'Louisville',
                    'state': 'KY',
                    'zipcode': 40213
                }
            }
        )
        batch.put_item(
            Item={
                'account_type': 'super_user',
                'username': 'alicedoe',
                'first_name': 'Alice',
                'last_name': 'Doe',
                'age': 27,
                'address': {
                    'road': '1 Jefferson Street',
                    'city': 'Los Angeles',
                    'state': 'CA',
                    'zipcode': 90001
                }
            }
        )
        print('batch writing')

def querying_table(table):

    response = table.query(
        KeyConditionExpression=Key('username').eq('johndoe')
    )
    items = response['Items']
    print('items with username = johndoe :',items)

def scanning(table):

    response = table.scan(
        FilterExpression=Attr('age').lt(27)
    )
    items = response['Items']
    print('items with age = 27 :',items)

def delete_table(table):

    table.delete()
    print('table deleted')


if __name__ == '__main__':
    dynamo = boto3.client('dynamodb')
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table('users')

    logging.basicConfig(
        filename='logs.log',
        level=logging.ERROR,
        format=f'%(asctime)s %(levelname)s %(message)s'
    )

    logger = logging.getLogger()
    logger.debug('The script is starting.')
    logger.info('Connecting to EC2...')

    create_table(dynamo)
    create_new_item(table)
    getting_item(table)
    #updating_item(table)
    #deleting_item(table)
    #batch_writing(table)
    #querying_table(table)
    #scanning(table)
    # delete_table(table)


