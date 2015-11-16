#!/bin/bash


# Slack sub-domain name (without '.slack.com'), user name, and the channel to send the message to
channel='#alert'
username='Zabbix'

# Associative array to deal with colors
declare -A severityArray=(
  ["Not_classified"]="#DBDBDB"
  ["Information"]="#D6F6FF"
  ["Warning"]="#FFF6A5"
  ["Average"]="#FFB689"
  ["High"]="#FF9999"
  ["Disaster"]="#FF3838"
)

# Get the Slack incoming web-hook token ($1) and Zabbix subject ($2 - hopefully either PROBLEM or RECOVERY)
token="https://hooks.slack.com/services/"
strSubject="$2"

# Extract status & severity from subject:
# * status [OK|PROBLEM]
# * severity [Not classified|Information|Warning|Average|High|Disaster]
arrSubject=(${strSubject//-/ })
status=${arrSubject[0]}
severity=${arrSubject[1]}

# Change message emoji depending on the status - smile (RECOVERY), frowning (PROBLEM), or ghost (for everything else)
emoji=':ghost:'
color='#FFFFFF'
if [ "$status" == 'RECOVERY' ]; then
  emoji=':smile:'
  color='good'
  title=${status}
elif [ "$status" == 'PROBLEM' ]; then
  emoji=':scream:'
  #color=${severityArray["${severity// /_}"]}
  color='CC0000'
  #title=${severity}
  title=${status}
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

/usr/bin/curl -m 5 --data "${payload}" "https://hooks.slack.com/services"
