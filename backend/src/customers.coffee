##
# CRUD methods for our customers.
#
# @author: Daniele Gazzelloni <daniele@danielegazzelloni.com>
######################################################################


db      = require('./db')
logger  = require('./logger')





# Insert a new customer into its Mongodb collection
insertCustomer = (customer, callback) ->

  thisCustomer = new db.models.Customers(customer)

  thisCustomer.save customer, (error, model) ->
    error = (error ? error : 200)
    model = (model ? model : {})
    callback(error, model)




# Retrieve a customer by id
getCustomer = (id, callback) ->

  db.models.Customers.findOne {_id: id}, (error, model) ->
    error = (error ? error : 200)
    model = (model ? model : {})
    callback(error, model)





# Edit a customer
editCustomer = (customer, callback) ->

  db.models.Customers.update {_id: customer._id}, customer, {}, (error, model) ->
    error = (error ? error : 200)
    model = (model ? model : {})
    callback(error, model)




# Identify which CRUD operation we should do.
#
# Note: we should implement processVerb() in every macro-module, like
# one for customers, one for users, one for moduleXXX, etc..
# This way we could use the same method syntax in the entire app.
processVerb = (req, verb, callback) ->

  # First discrimination
  if verb is "GET"

    # GET a customer
    if req.query.id
      getCustomer req.query.id, (error, result) ->
        logger.log "*", "getting customer with id=#{req.query.id}";
        callback(error, result)
    else
      logger.log "*", "ERROR: getting customer with id undefined.";
      callback(400, {})

  else if verb is "POST"

    # INSERT a customer
    if (req.body.id is null or req.body.id is undefined) and req.body.name and req.body.email
      customer = {
        name  : req.body.name,
        email : req.body.email,
        barber: req.body.barber
      }

      insertCustomer customer, (error, result) ->
        logger.log "*", "customer #{customer.name} inserted.";
        callback(error, result)

    # EDIT a customer
    else if req.body.id and req.body.name and req.body.email
      customer = {
        _id   : req.body.id,
        name  : req.body.name,
        email : req.body.email,
        barber: req.body.barber
      }

      editCustomer customer, (error, result) ->
        logger.log "*", "customer #{customer.name} edited.";
        callback(error, result)

    else
      logger.log "*", "ERROR: wrong parameters for editCustomer/insertCustomer...";
      callback(400, {})

  # Unrecognized method
  else
    logger.log "*", "WARNING: unrecognized method...";
    callback(400, {})




# Module exports
exports.insertCustomer  = insertCustomer
exports.getCustomer     = getCustomer
exports.editCustomer    = editCustomer
exports.processVerb     = processVerb