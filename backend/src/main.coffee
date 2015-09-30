
##
# This is an example of a generic express main file. Let's think it is
# your main express file: you can include my server.coffee without generating conflicts.
#
# See code below for how-to.
#
# @author: Daniele Gazzelloni <daniele@danielegazzelloni.com>
######################################################################


## BASE SETUP
## ==============================================

express       = require 'express'
config        = require './config'
logger        = require './logger'
routing       = require './routing'

app           = express()
port          = process.env.PORT || config.serverPort;



# To start the backend server:
routing.serveRoutes(app)



## STARTS SERVER
## ==============================================

app.listen port, () ->
  logger.log "*", "listening on port #{this.address().port}."
