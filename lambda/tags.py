#特定インスタンスのTags情報を取る場合
import boto3
 
def lambda_handler(event, context):
    client = boto3.client('ec2')
    response = client.describe_instances(
    InstanceIds=['xxxxxxxx']
        )
    print response['Reservations'][0]["Instances"][0]["Tags"][0]
