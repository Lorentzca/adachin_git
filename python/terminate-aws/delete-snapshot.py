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
             


##スナップショットのTagsでKeyが「nodelete」Valueが「true」以外削除
# coding: utf-8
#EC2 snapshot delete
import boto3

# nodelete,trueを変数化
ND = 'nodelete'
TR = 'true'

def lambda_handler(event, context):
#if __name__ == '__main__': #EC2上
    ec2 = boto3.client('ec2')
    resp = ec2.describe_snapshots()
    all_list = []
    del_list = []
    #print (resp)
    for snapshots in resp['Snapshots']:
      for snapshotid in snapshots['SnapshotId']:
        all_list.append(snapshots['SnapshotId'])
#        print(all_list)

        if 'Tags' in snapshots:
          for tag in snapshots['Tags']:
#          print(tag)
            if tag['Key'] == ND and tag['Value'] == TR:
              del_list.append(snapshots['SnapshotId'])
#              print(del_list)

    diffset = set(all_list) - set(del_list)
#   print(diffset)
    targetlist = list(diffset)
#    print(targetlist)
      resp = ec2.delete_snapshot(
        GroupId=targetlist
      )

