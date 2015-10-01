##
# Testing API:
#   "http://localhost:8081/customers"
#
# See README.md for detailed info.
#
# @author: Daniele Gazzelloni <daniele@danielegazzelloni.com>
######################################################################


# We will use Unit.js as testing framework
test    = require('unit.js')
mongoose= require('mongoose')
config  = require('../backend/src/config')
db      = require('../backend/src/db')
request = test.httpAgent(config.serverUrl)


describe 'Customers API unit test', ->

  # Customer object
  customer = {
    name: "John Travolta",
    email: "john.travolta@johntravolta.com",
    barber: "Jimmy"
  }

  # Same above, but with id (used for GET, EDIT)
  customerWithId = {
    _id : new mongoose.Types.ObjectId()
    name: "Alicia Keys",
    email: "alicia.keys@mywebsiteisthebest.com",
    barber: "Jax"
  }

  dummyCustomer = {}

  # We will need try to open mongoose connection using db.initData,
  # then inserting a dummy value for the EDIT and GET methods
  before (done) ->
    # Init our DB schemas and models
    db.initData () ->

      # Dummy customer object (Mongo Model)
      dummyCustomer = new db.models.Customers(customerWithId)

      # Save it
      dummyCustomer.save dummyCustomer, (error, model) ->
        if error then throw error
        done()


  # We also gonna remove our dummy customer.
  after (done) ->
    dummyCustomer.remove {_id: customerWithId._id}, (error) ->
      if error then throw error
      done()


  # Testing POST verb: inserting a new customer
  it 'Insert customer', (done) ->

    request
    .post(config.customersAPI)
    .send(customer)

    # Our API will return inserted customer as a JSON
    .expect('Content-Type', /json/)
    .expect(200)

    # ...and handling the response
    .end (err, res) ->

      if err then test.fail(err.message)

      res.body.should.have.property('_id')
      res.body.name.should.equal(customer.name)
      res.body.email.should.equal(customer.email)
      res.body.barber.should.equal(customer.barber)

      done()

  # Testing POST verb: editing a customer
  it 'Edit customer', (done) ->
    editedCustomer = {
      _id : customerWithId.barber._id,
      name: "Alicia Losther Keys",
      email: customerWithId.email,
      barber: customerWithId.barber
    }

    request
    .post(config.customersAPI)
    .send(editedCustomer)

    # Our API will return edited customer as a JSON
    .expect('Content-Type', /json/)
    .expect(200)

    # ...and handling the response
    .end (err, res) ->

      if err then test.fail(err.message)

      res.body.should.have.property('_id')
      res.body.name.should.equal(editedCustomer.name)
      res.body.email.should.equal(editedCustomer.email)
      res.body.barber.should.equal(editedCustomer.barber)

      done()


  # Testing GET verb: get a customer by id.
  # We will use the first customer._id as id (we got it from the previous test case call).
  it 'Get customer', (done) ->

    request
    .get(config.customersAPI)
    .query("id=#{customerWithId._id}")

    # Our API will return edited customer
    .expect('Content-Type', /json/)
    .expect(200)

    # ...and handling the response
    .end (err, res) ->

      if err then test.fail(err.message)
      
      res.body.name.should.equal(customerWithId.name)
      res.body.email.should.equal(customerWithId.email)
      res.body.barber.should.equal(customerWithId.barber)

      done()


