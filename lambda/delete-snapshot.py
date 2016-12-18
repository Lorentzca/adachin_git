##スナップショットのTagsでKeyが「nodelete」Valueが「true」の場合に削除
# coding: utf-8
import boto3
 
def lambda_handler(event, context):
#if __name__ == '__main__': #EC2の場合
    ec2 = boto3.client('ec2')
    resp = ec2.describe_snapshots()
    for snapshots in resp['Snapshots']:
               if 'Tags' in snapshots:

                for tag in snapshots['Tags']:
                    if tag['Key'] == "nodelete" and tag["Value"] == "true":
                       #print(snapshots["SnapshotId"]) #出力
                       #print list #出力
                       ec2.delete_snapshot(
                          SnapshotId=snapshots["SnapshotId"]
                       )
