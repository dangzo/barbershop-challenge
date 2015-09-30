
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
db            = require './db'

app           = express()
port          = process.env.PORT || config.serverPort;



# To start the backend server:
routing.serveRoutes(app)



## STARTING BACK-END SERVER
## ==============================================

app.listen port, () ->
  logger.log "*", "listening on port #{this.address().port}."




## STARTING DB (Mongo)
## ==============================================

db.connection.on "open", (callback) ->
  # Init Mongo models and schemas
  db.initData () ->
    logger.log("*", "successfully connected to "+config.dbHostname+" (Mongo).")

db.connection.on "error", (callback) ->
  logger.log("*", "error connecting to "+config.dbHostname+" (Mongo)")