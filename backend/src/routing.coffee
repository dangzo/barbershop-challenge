
##
# Routing.
# This module can be included in any express app without generating conflicts.
# Just pass express() through variable to serveRoutes().
#
# @author: Daniele Gazzelloni <daniele@danielegazzelloni.com>
######################################################################


## BASE SETUP
## ==============================================

express       = require 'express'
bodyParser    = require 'body-parser'
config        = require './config'
logger        = require './logger'


# Restrict Access-Control directives as your needs
allowCrossDomain = (req, res, next) ->
  res.header "Access-Control-Allow-Origin", "*"
  res.header "Access-Control-Allow-Credentials", "true"
  res.header 'Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE'
  res.header "Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept"
  next();






# Method for serving routes
serveRoutes = (app) ->

  app.use allowCrossDomain
  app.use bodyParser.json({limit: '25mb'})
  app.use bodyParser.urlencoded({ extended: false, limit: '25mb' })


  # Serve the html directory as static
  app.use '/', express.static("#{__dirname}/../../frontend/build")

  ## ROUTES
  ## ==============================================

  app.get '/test', (req, res) ->
    logger.log ">", "test service called."
    res.send "It works!"



# Module exports
exports.serveRoutes   = serveRoutes
