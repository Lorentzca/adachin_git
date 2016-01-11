#!/bin/sh

set -eu

#Incoming WebHooksのURL
WEBHOOKURL="https://hogee" 
#メッセージを保存する一時ファイル
MESSAGEFILE=$(mktemp -t webhooks)
trap " 
rm ${MESSAGEFILE}
" 0

usage_exit() {
    echo "Usage: $0 [-m message] [-c channel] [-i icon] [-n botname]" 1>&2
    exit 0
}

while getopts c:i:n:m: opts
do
    case $opts in
        c)
            CHANNEL=$OPTARG
            ;;
        i)
            FACEICON=$OPTARG
            ;;
        n)
            BOTNAME=$OPTARG
            ;;
        m)
            MESSAGE=$OPTARG"\n" 
            ;;
        \?)
            usage_exit
            ;;
    esac
done
#slack 送信チャンネル
CHANNEL=${CHANNEL:-"#hoge"}
#slack 送信名
BOTNAME=${BOTNAME:-"hoge"}
#slack アイコン
FACEICON=${FACEICON:-"hoge"}
#見出しとなるようなメッセージ
MESSAGE=${MESSAGE:-""}

if [ -p /dev/stdin ] ; then
    #改行コードをslack用に変換
    cat - | tr '\n' '\\' | sed 's/\\/\\n/g'  > ${MESSAGEFILE}
else
    echo "nothing stdin" 
    exit 1
fi

WEBMESSAGE='```'`cat ${MESSAGEFILE}`'```'

#Incoming WebHooks送信
curl -s -S -X POST -d "payload={\"channel\": \"${CHANNEL}\", \"username\": \"${BOTNAME}\", \"icon_emoji\": \"${FACEICON}\", \"text\": \"${MESSAGE}${WEBMESSAGE}\" }" ${WEBHOOKURL} >/dev/null
