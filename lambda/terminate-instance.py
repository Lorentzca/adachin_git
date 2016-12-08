#特定インスタンスを削除する場合
import boto3
 
def lambda_handler(event, context):
    client = boto3.client('ec2')
    response = client.terminate_instances(
        InstanceIds=['xxxxxxxxx']
        )
    print  response
