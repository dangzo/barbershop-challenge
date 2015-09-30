##
# Testing API:
#   "http://localhost:8081/customers"
#
# See README.md for detailed info.
#
# @author: Daniele Gazzelloni <daniele@danielegazzelloni.com>
######################################################################


# We will use Unit.js as testing framework
tests = require('unit.js')
mongoose = require('mongoose')
config = require('../backend/src/config')



# Preliminar operations: connecting to db to ensure it is up and running.
before (done) ->
  # In our tests we use the test db
  mongoose.connect(config.dbHostname)
  done


describe 'Customers API unit test', ->

  customer = {
    name: "John Travolta",
    email: "john.travolta@johntravolta.com",
    barber: "Jimmy"
  }


  # Testing ADD verb...
  it 'insert a customer into DB', ->

    request(config.serverUrl)
    .post(config.customersAPI)
    .send({
      action: "ADD",
      customer: customer
    })

    # Our API will return inserted customer
    .expect('Content-Type', /json/)

    # ...and handling the response
    .end (err, res) ->

      if err then throw err

      res.should.have.status(200)
      res.body.should.have.property('_id')
      res.body.name.should.equal(customer.name)
      res.body.email.should.equal(customer.email)
      res.body.barber.should.equal(customer.barber)

      done


  # Testing EDIT verb
  it 'edit a customer entry', ->

    customer.name = "John N'altravolta"

    request(config.serverUrl)
    .post(config.customersAPI)
    .send({
        action: "EDIT",
        customer: customer
      })

    # Our API will return edited customer
    .expect('Content-Type', /json/)

    # ...and handling the response
    .end (err, res) ->

      if err then throw err

      res.should.have.status(200)
      res.body.should.have.property('_id')
      res.body.name.should.equal(customer.name)
      res.body.email.should.equal(customer.email)
      res.body.barber.should.equal(customer.barber)

      # Save _id field for later use.
      customer._id = res.body._id

      done


  # Testing GET verb: get a customer by id.
  # We will use the first customer._id as id (we got it from the previous test case call).
  it 'get a customer by id', ->

    request(config.serverUrl)
    .get(config.customersAPI)
    .send({
        _id: customer._id
      })

    # Our API will return edited customer
    .expect('Content-Type', /json/)

    # ...and handling the response
    .end (err, res) ->

      if err then throw err

      res.should.have.status(200)
      res.body._id.should.equal(customer._id)
      res.body.name.should.equal(customer.name)
      res.body.email.should.equal(customer.email)
      res.body.barber.should.equal(customer.barber)

      done

