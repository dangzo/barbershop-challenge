
##
# Routing.
# GET and POST APIs here.
#
# @author: Daniele Gazzelloni <daniele@danielegazzelloni.com>
######################################################################


## BASE SETUP
## ==============================================

express       = require 'express'
bodyParser    = require 'body-parser'
config        = require './config'
logger        = require './logger'
customers     = require './customers'


# Restrict Access-Control directives as your needs
allowCrossDomain = (req, res, next) ->
  res.header "Access-Control-Allow-Origin", "*"
  res.header "Access-Control-Allow-Credentials", "true"
  res.header 'Access-Control-Allow-Methods', 'GET,POST'
  res.header "Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept"
  next();






# Method for serving routes
serveRoutes = (app) ->

  app.use allowCrossDomain
  app.use bodyParser.json({limit: '25mb'})
  app.use bodyParser.urlencoded({ extended: false, limit: '5mb' })


  ## ROUTES
  ## ==============================================

  app.get config.customersAPI, (req, res) ->
    logger.log ">", "#{config.customersAPI} (GET) called."
    customers.processVerb req, "GET", (status, result) ->
      res.status(status).json(result)

  app.post config.customersAPI, (req, res) ->
    logger.log ">", "#{config.customersAPI} (POST) called."
    customers.processVerb req, "POST", (status, result) ->
      res.status(status).json(result)



# Module exports
exports.serveRoutes   = serveRoutes
