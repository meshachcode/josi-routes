# Description:
#
# Dependencies:
#
# Configuration:
#   None
#
# Commands:
#   None
#
# URLs:
#
# Author:
#   meshachjackson

querystring = require('querystring')

class Browse

  constructor: () ->
    @

  template: (name, response) ->
    """
  <html>
    <head>
    <title>#{name} Help</title>
    <style type="text/css">
      body {
        background: #fefefe;
        color: #33336d;
        text-shadow: 0 1px 1px rgba(255, 255, 255, .5);
        font-family: Helvetica, Arial, sans-serif;
        height: 100%;
      }
      section {
        width: 600px;
        margin-left: auto;
        margin-right: auto;
        margin-top: 100px;
      }
      section div {
        margin: 20px 0;
      }
      h1 {
        font-size: 7em;
        margin: 0;
      }
      h1, h3 {
        width: 100%;
        text-align: center;
      }
      h3 {
        font-weight: normal;
        font-size: .8em;
        color: #888888;
      }
      #response {
        font-size: 1.5em;
        line-height: 1.5em;
        width: 100%;
        text-align: center;
        background-color: #eeeeed;
        padding: 20px;
      }
      #question {
        width: 100%;
        text-align: center;
        background-color: #eeeeed;
        padding: 20px;
      }
      #question input[name=question] {
        line-height: 1.5em;
        font-size: 1.5em;
        color: #333366;
        width: 100%;
        text-align: center;
      }
      p {
        border-bottom: 1px solid #ededed;
        margin: 6px 0 0 0;
        padding-bottom: 5px;
      }
      p:last-child {
        border: 0;
      }
    </style>
    </head>
    <body>
      <section>
        <h3>hi. my name is</h3>
        <h1>#{name}</h1>
        <div id="question">
          <div>What would you like to talk about?</div>
          <form method="GET" action="/#{name}/interract">
            <input type="text" name="question"></input>
          </form>
        </div>
        <div id="response">#{response}</div>
      </section>
    </body>
  </html>
    """

module.exports = (robot) ->

  robot.browse = new Browse()

  robot.router.get "/#{robot.name}/browse", (req, res) ->
    cmds = robot.helpCommands().map (cmd) ->
      cmd.replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;')
    emit = "<p>#{cmds.join '</p><p>'}</p>"
    emit = emit.replace /hubot/ig, "<b>#{robot.name}</b>"

    res.setHeader 'content-type', 'text/html'
    res.end robot.browse.template robot.name, "..."

  robot.router.get "/#{robot.name}/interract", (req, res) ->
    res.setHeader 'content-type', 'text/html'
    robot.logger.info req.query
    res.end robot.browse.template robot.name, "Okay great. Now I'm going to try and answer <br />'#{req.query.question}'..."
