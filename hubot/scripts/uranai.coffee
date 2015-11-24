random = (n) -> Math.floor(Math.random() * n)

module.exports = (robot) ->
  robot.respond /今日の占い/i, (msg) ->
  #robot.respond /(占い|運勢|)/i, (msg) ->
    fortunes = [
      '大吉でございます！',
      '末吉でございます！',
      '大凶・・・あまり気になさらないでください'
    ]
    result = fortunes[random(3)]
    msg.send "#{result}"
