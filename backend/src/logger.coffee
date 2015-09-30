##
# Logger module.
# Used for logging to STDOUT/FILE.
#
# @author: Daniele Gazzelloni <daniele@danielegazzelloni.com>
######################################################################


config = require './config'


# Log out on console in a specific format data
log = (type, message) ->
  if type.length>1
    process.stdout.write("[#{currentTime()}] #{type.substr(0, 1)} #{config.appName}: #{message}")
  else
    console.log("[%s] %s %s: %s", currentTime(), type, config.appName, message)


# Formats current time to: 'hh24:mi:ss'
currentTime = () ->
  date = new Date()
  h = date.getHours()
  mi = date.getMinutes()
  s = date.getSeconds()
  # Not the easiest syntax to read, I know...
  "#{if h>9 then h else "0"}h:#{if mi>9 then mi else "0#{mi}"}:#{ if s>9 then s else "0#{s}"}"


# Module exports
exports.log = log
