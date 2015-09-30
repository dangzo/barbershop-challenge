##
# CRUD methods for our customers.
#
# @author: Daniele Gazzelloni <daniele@danielegazzelloni.com>
######################################################################


# Identify which CRUD operation we should do.
#
# Note: we should implement processVerb() in every macro-module, like
# one for customers, one for users, one for moduleXXX, etc..
# This way we could use the same method syntax in the entire app.
exports.processVerb = (req, verb, callback) ->

  # First discrimination
  if verb is "GET"

    # GET a customer
    if not req.get._id is null
      getCustomer req.get._id, (result) ->
        callback(200, result)

  else if verb is "POST"

    # INSERT a customer
    if req.body._id is null and (not req.body.name) and (not req.body.email)
      name = req.post.name
      email = req.post.email
      barber = req.post.barber

      insertCustomer name, email, barber, (result) ->
        callback(200, result)

    # EDIT a customer
    else if (not req.body._id is null) and ((not req.body.name) or (not req.body.email) or (not req.body.barber))
      id = req.body._id
      name = req.post.name
      email = req.post.email
      barber = req.post.barber

      editCustomer id, name, email, barber, (result) ->
        callback(200, result)

    else
      callback(400, result)

  # Unrecognized method
  else
    callback(400, {})