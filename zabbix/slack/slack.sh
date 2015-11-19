#!/bin/bash


# Slack sub-domain name (without '.slack.com'), user name, and the channel to send the message to
channel='#hoge'
username='Zabbix'

# Get the Slack incoming web-hook token ($1) and Zabbix subject ($2 - hopefully either PROBLEM or RECOVERY)
token="https://hooks.slack.com/services/hoge"
strSubject="$2"

# Extract status & severity from subject:
# * status [OK|PROBLEM]
# * severity [Not classified|Information|Warning|Average|High|Disaster]
arrSubject=(${strSubject//-/ })
status=${arrSubject[0]}
severity=${arrSubject[1]}

# Change message emoji depending on the status - smile (RECOVERY), frowning (PROBLEM), or ghost (for everything else)
emoji=':zabbix:'
color='#FFFFFF'

if [ ! -z "$status" ]; then
  if [[ $status == 'CRITICAL' ]] || [[ $status == 'critical' ]]; then
    emoji=':tired_face:'
    color="#FF1D00";
    title=${status}
  elif [[ $status == 'WARNING' ]] || [[ $status == 'warning' ]]; then
    emoji=':anguished:'
    color="#FFFF00";
    title=${status}
  elif [[ $status == 'UNKNOWN' ]] || [[ $status == 'unknown' ]]; then
    emoji=':thinking_face:'
    color="#8C8C8C";
    title=${status}
  elif [[ $status == 'OK' ]] || [[ $status == 'ok' ]]; then
    emoji=':laughing:'
    color="#0BDA51";
    title=${status}
  elif [[ $status == 'RECOVERY' ]] || [[ $status == 'recovery' ]]; then
    emoji=':relieved:'
    color="#0BDA51";
    title=${status}
  elif [[ $status == 'DOWN' ]] || [[ $status == 'down' ]]; then
    emoji=':scream:'
    color="#FF1D00";
    title=${status}
  elif [[ $status == 'PROBLEM' ]] || [[ $status == 'problem' ]]; then
    emoji=':fearful:'
    color="#FF1D00";
    title=${status}
  elif [[ $status == 'UP' ]] || [[ $status == 'up' ]]; then
    emoji=':flushed:'
    color="#439FE0";
    title=${status}
  fi
fi

# Prepare attachment payload so that we can customize
# how Slack will display allert
attachment="
{
  \"title\":\"${title}\",
  \"fallback\":\"*${title}*\n$3\",
  \"text\":\"$3\",
  \"color\":\"${color}\",
  \"mrkdwn_in\": [\"text\", \"title\", \"fallback\"]
}"

# Build our JSON payload and send it as a POST request to the Slack incoming web-hook URL
payload="payload={\"channel\": \"${channel}\", \"username\": \"${username}\", \"icon_emoji\": \"${emoji}\", \"attachments\":[${attachment}]}"

/usr/bin/curl -m 5 --data "${payload}" "https://hooks.slack.com/services/"

# zabbix command
/usr/lib/zabbix/alertscripts/slack.sh '@hoge' "{TRIGGER.STATUS}-{HOSTNAME}" "{TRIGGER.NAME}-{ITEM.VALUE1}"
