# Description:
#   Hubot, be polite and say hello.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   Hello or Good Day make hubot say hello to you back
#   Good Morning makes hubot say good morning to you back
hellos = [
    "おはようございます",
    "お腹すきましたね",
    "少し眠くなって参りました",
    "はい？",
    "がんばりましょう！",
    "いいですね"
]
mornings = [
    "なんかよう？",
    "はい？",
    "いいね",
    "はらへい(・∀・)"
]
module.exports = (robot) ->
    robot.respond /(おい|はい|こんにちわ|やあ|ねむい|眠い|good( [d'])?ay(e)?)/i, (msg) ->
        hello = msg.random hellos
        msg.send hello.replace "%", msg.message.user.name

    robot.respond /(^(はい )?m(a|o)rnin(g)?)/i, (msg) ->
        hello = msg.random mornings
        msg.send hello.replace "%", msg.message.user.name
