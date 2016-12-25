# coding: utf-8
#ELB delete
import boto3

# nodelete,trueを変数化
ND = 'nodelete'
TR = 'true'

def lambda_handler(event, context):
#if __name__ == '__main__':
  client = boto3.client('elb')
# loadbalancersの情報を変数化
  resp = client.describe_load_balancers()
# loadbalancerNameでtagを出力
#  print resp
  for elb in resp['LoadBalancerDescriptions']:
    resp2 = client.describe_tags(
      LoadBalancerNames=[elb['LoadBalancerName']]
    )
#     print(resp2)
# tagが空の場合を出力
    for tag in resp2['TagDescriptions']:
#     print tag
      if len(tag['Tags']) == 0:
        print(elb['LoadBalancerName'])
# tagがnodelete以外を出力
        for k in tag['Tags']:
          print k
          if not k['Key'] == ND and not k['Value'] == TR:
            print(elb['LoadBalancerName'])
    response = client.delete_load_balancer(
        LoadBalancerName=elb['LoadBalancerName']
    )

#ALB delete
def lambda_handler(event, context):
#if __name__ == '__main__':
  client = boto3.client('elbv2')
# loadbalancersの情報を変数化
  resp = client.describe_load_balancers()
# loadbalancerNameでtagを出力
#    print resp
  for alb in resp['LoadBalancers']:
    resp2 = client.describe_tags(
      ResourceArns=[alb['LoadBalancerArn']]
    )
#     print(resp2)
# tagが空の場合を出力
    for tag in resp2['TagDescriptions']:
#       print tag
        if len(tag['Tags']) == 0:
          print(alb['LoadBalancerArn'])
# tagがnodelete以外を出力
          for a in tag['Tags']:
            print a
            if not a['Key'] == ND and not k['Value'] == TR:
                print(alb['LoadBalancerArn'])
    response = client.delete_load_balancer(
        LoadBalancerArn=alb['LoadBalancerArn']
    )
