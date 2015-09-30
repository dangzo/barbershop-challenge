##
# Mongoose CRUD operations, schemas and models definitions.
#
# @author: Daniele Gazzelloni <daniele@danielegazzelloni.com>
######################################################################

db = mongoose.connect(config.db_hostname).connection


# Customers schema and model objects
this.schemas = {}
this.models  = {}



# Initialize Mongo schemas and models
exports.initData = (callback) ->

  this.schemas.customer = new mongoose.Schema({
    name: {type: String},
    email: {type: String},
    barber: {type: String}
  });

  # Init models
  this.models.Customer = mongoose.model("Customer", schemas.customer);

  # call the callback
  callback()




