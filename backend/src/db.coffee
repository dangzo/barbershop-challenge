##
# Mongoose CRUD operations, schemas and models definitions.
#
# @author: Daniele Gazzelloni <daniele@danielegazzelloni.com>
######################################################################

mongoose  = require('mongoose')
config    = require('./config')


# Our db connection
db = mongoose.connect(config.dbHostname)
db = mongoose.connection

# Customers schema and model objects
schemas = {}
models  = {}



# Initialize Mongo schemas and models
exports.initData = (callback) ->

  schemas.customers = new mongoose.Schema({
    name: {type: String},
    email: {type: String},
    barber: {type: String}
  });

  # Init models
  models.Customers = mongoose.model("Customers", schemas.customers);

  # call the callback
  callback()



# Module exports
exports.schemas     = schemas
exports.models      = models
exports.connection  = db




