hellos = [
    "とんでもございません",
    "また何かあれば言ってください",
    "いえいえ"
]
module.exports = (robot) ->
    robot.respond /(ありがとう|good( [d'])?ay(e)?)/i, (msg) ->
        hello = msg.random hellos
        msg.send hello.replace "%", msg.message.user.name
