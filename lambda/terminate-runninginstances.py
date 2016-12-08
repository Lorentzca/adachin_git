#Keyが「adachin」Valueが「running」のインスタンスを削除する
import boto3
 
def lambda_handler(event, context):
    client = boto3.client('ec2')
    resp = client.describe_instances()
    list = []
    for reservation in resp['Reservations']:
        for instance in reservation['Instances']:
               if 'Tags' in instance:

                for tag in instance['Tags']:
                    if tag['Key'] == 'adachin' and tag["Value"] == 'running':
                       #print(instance["InstanceId"]) #ただの出力
                       list.append(instance["InstanceId"])
                       #print list #ただの出力
    client.terminate_instances(
        InstanceIds=list
    )
