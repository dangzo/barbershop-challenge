# barbershop-challenge
This is a Node.js (CoffeeScript) small project used to simulate the back-end of a "fictitious" external web/mobile app.
  
## The Problem
A barbershop has always used a paper-based mailing list which allows the barbershop to stay in touch with their customers. They now want to modernise the email list and make it digital and easily accessible.

An iOS developer developed an app for them and now they’re looking to save the customers information in a database using a Node.js based REST API.
 
This API should provide the app with the following features and functionality: 
- Adding new customers
- Getting and returning customer by id
- Editing customer details
 
### Technical Considerations:
- MongoDB should be used as database
- Code should come with unit tests.
- Request validation is expected if required
- Express should be used as framework
 
### Bonus:
- REST best practices
- CoffeeScript Code
- Readable code
- Maintainable code
- Handling duplicate email cases
- Documentation (README.md)


## Installation
Use the followings:

    $ git clone https://github.com/danielegazzelloni/barbershop-challenge
    $ cd barbershop-challenge 
    $ npm install


## Run
You can start the back-end with:

    $ npm start
    
    
## How it works

There is only one active API, `http://localhost:8081/customers`

1. To get a list of customers, just call it as it is:
    
        http://localhost:8081/customers    
    
    You will get an array of customers in the following format:
    
        [
            {
                id: <int>,
                name: <string>,
                email: <string>,
                barber: <string>
            }
        ]
    
2. To get a specific customer in detail, call it with the `id` parameter:

        http://localhost:8081/customers?id=12345

    This time you will get a single element:

        {
            id: <int>,
            name: <string>,
            email: <string>,
            barber: <string>
        }

    
3. To edit customers details send a POST call to the same API with these parameters:

    - `id (int)` : mandatory, it is the customer id we want to edit.
    - `name (string)` : optional, it's our customer name.
    - `email (string)` : optional, it's our customer email.
    - `barber (string)` : optional, it's the preferred barber. If it's null or empty, an error is returned.


## Tests
(update soon)