module.exports = (robot) ->
  robot.hear /再起動|リリース|更新します/, (msg) ->
    msg.send msg.random ["はい!", "了解です!", "把握!","なるほど!","ラジャー"]
