# README
## Description

BarStock is a 13-day, four-person project during Mod 4 of 4, for Turing School's Back-End Engineering Program. Our team consists of two Front-End Developers and two Back-End Developers.

Our challenge was to create a web application from idea to inception by integrating our skills as Front-End and Back-End Developers to solve a real-world problem.

Thus, BarStock was born. BarStock is a web application designed to solve the communication challenges between bar owners and distributors when placing inventory orders. In the bar industry, it is currently common practice to place weekly inventory orders via via text message communication with a distributor representative. Bar owners are not provided with pricing sheets and frequently do not know pricing, nor available inventory until several text message inquiries later. BarStock is intended to alleviate this headache by providing a user interface for bar owners to view distributor inventory, analyze profit margins, and automate text message ordering.

BarStock Back-End utilizes Ruby on Rails, RSpec, ActiveRecord, and a PostgreSQL database. The [BarStock User Interface](https://github.com/MRKrog/barstock-ui) and BarStock Back-End communicate via API requests/responses.

#### [**_Utilizes BarStock Back-End in Production_**](https://barstock-backend.herokuapp.com)

## Schema
![Alt text](./public/images/schema.png?raw=true "Database Schema")

## Available Endpoints
All available endpoints have been documented on [Swagger]() <<<<<--------------INERT LINK FOR PUBLISHED ENDPOINTS------------------------
![Alt text](./public/images/swagger_endpoints.png?raw=true "Endpoint Documentation")


![Alt text](./public/images/email_sample.png?raw=true "Order Email")

<!-- Add giphy of Front End -->

## Getting Started

To run BarStock Back-End on a local machine, navigate to the directory in which you would like the project to be located, then execute the following commands:

```
$ git clone git@github.com:MRKrog/barstock_backend.git
$ cd barstock_backend
$ bundle
$ rails g rspec:install
$ rails db:create
$ rails db:migrate
$ rails db:seed
$ figaro install
```

#### Environment Variable Setup:

 Create Accounts With The Following Services:
* [Twilio](https://www.twilio.com/)
* [Sendgrid](https://app.sendgrid.com)

Add the following code snippet to the `config/application.yml` file. Make sure to insert the key/secret without the alligator clips ( < > ).
```
TWILIO_ACCOUNT_SID: <insert>
TWILIO_AUTH_TOKEN: <insert>
TWILIO_PHONE_NUMBER: <insert utilizing the format of '+1720993333'>
SENDGRID_PASSWORD: <insert>
```

### Running Tests

To run the test suite, execute the following command:
`rspec`.

### Deployment

To view BarStock in development, execute the following command from the project directory: `rails s`. In a browser, visit `localhost:3000`, to view the application.

To view the application in production, from the project directory, execute the following commands:

```
$ createuser -s -r barstock_backend
$ RAILS_ENV=production rake db:{drop,create,migrate,seed}
$ rake assets:precompile
$ rails s -e production
```

## Available Endpoints
<!--  INSERT ENDPOINT DOCUMENTATION HERE -->

## Tools Utilized:

* Fast JSON API
* RSpec
* Faraday
* Figaro
* Faraday
* Capybara
* Pry
* Shoulda-Matchers
* Factory Bot
* Database Cleaner
* SimpleCov
* Bcrypt
* Faker
* Awesome Print
* WebMock
* VCR
* Trello
* Postman
* Circle CI
* Sendgrid
* [HTML Email Template](https://github.com/sendgrid/email-templates/blob/master/dynamic-templates/receipt/receipt.html)
* Twilio
* Mailcatcher

## Known Issues
<!-- INSERT KNOWN ISSUES HERE -->

## How to Contribute

###### Contributing Code:
1. Fork the project.
2. Write a failing test.
3. Commit that failing tests.
4. Commit changes that fix the tests.
4. Submit a pull request detailing the change that was made.

###### Submitting a Bug:
1. Search the existing [issues](https://github.com/nagerz/quantified_self/issues).
2. Create a new issue if applicable, or contribute to an existing issue.

### Related Links:
###### [**_Agile Project Board_**](https://trello.com/b/jD2vXUGS/barstock)
###### [**_Project Specifications_**](http://backend.turing.io/module4/projects/cross_pollination/cross_pollination_spec)
###### [**_Project Rubric_**](http://backend.turing.io/module4/projects/cross_pollination/cross_pollination_rubric)

### Authors
* [Michael Krog](https://github.com/MRKrog)
* [Julia Marco](https://github.com/juliamarco)
* [Gabriel Inzurriaga](https://github.com/Inzurriaga)
* [Mackenzie Frey](https://github.com/Mackenzie-Frey)


### Acknowledgments
* [Dione Wilson](https://github.com/dionew1)
* [Cory Westerfield](https://github.com/corywest)
* [David Whitaker](https://github.com/damwhit)
* [Will Mitchell](https://github.com/wvmitchell)
