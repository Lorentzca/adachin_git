cron = require('cron').CronJob

module.exports = (robot) ->
  new cron '55 16 * * 5', () =>
    robot.send {room: "#test"}, "17:00~テストです!"
  , null, true, "Asia/Tokyo"


