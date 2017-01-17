#!/usr/bin/env bash


#aws dynamodb delete-table --table-name campaign_imp

aws dynamodb create-table \
    --table-name campaign_imp \
    --attribute-definitions \
        AttributeName=id,AttributeType=S \
    --key-schema AttributeName=id,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1

aws dynamodb list-tables 

 aws dynamodb put-item --table-name campaign_imp --item '{"id":{"S":"campaign-0001-cccc-dddd-eeeeeeeeeeee"}, "imp":{"S":"12000"}}'
 aws dynamodb put-item --table-name campaign_imp --item '{"id":{"S":"campaign-0002-cccc-dddd-eeeeeeeeeeee"}, "imp":{"S":"13000"}}'
 aws dynamodb put-item --table-name campaign_imp --item '{"id":{"S":"campaign-0003-cccc-dddd-eeeeeeeeeeee"}, "imp":{"S":"13"}}'
 aws dynamodb put-item --table-name campaign_imp --item '{"id":{"S":"campaign-0004-cccc-dddd-eeeeeeeeeeee"}, "imp":{"S":"14"}}'
 aws dynamodb put-item --table-name campaign_imp --item '{"id":{"S":"campaign-0005-cccc-dddd-eeeeeeeeeeee"}, "imp":{"S":"15"}}'
 aws dynamodb put-item --table-name campaign_imp --item '{"id":{"S":"campaign-0006-cccc-dddd-eeeeeeeeeeee"}, "imp":{"S":"16"}}'
 aws dynamodb put-item --table-name campaign_imp --item '{"id":{"S":"campaign-0010-cccc-dddd-eeeeeeeeeeee"}, "imp":{"S":"3"}}'
