#Keyが「nodelete」Valueが「true」のセキュリティーグループを削除する
#EC2 SecurityGroups delete
import boto3
 
def lambda_handler(event, context):
#if __name__ == '__main__': #EC2の場合
    ec2 = boto3.client('ec2')
    resp = ec2.describe_security_groups()
    #print (resp)
    for securitygroups in resp['SecurityGroups']:
        if 'Tags' in securitygroups:

            for tag in securitygroups['Tags']:
                if tag['Key'] == 'nodelete' and tag["Value"] == 'true':
                    #print(securitygroups["GroupId"]) #出力
                    resp = ec2.delete_security_group(
                        GroupId=securitygroups["GroupId"]
                    )
