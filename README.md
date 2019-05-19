# README
## Description

BarStock is an 11-day, four-person project during Mod 3 of 4, for Turing School's Back-End Engineering Program.

Our challenge was to create a web application from idea to inception. Project requirements included: authentication with a third-party service, consuming an API, and solving a real-world problem.

Thus, BarStock was born. BarStock is a web application designed to solve the problem of one person being in charge of the music at a party and being unable to take into account all of the music preferences of their fellow party-goers. BarStock enables users to create a collaborative music experience by logging into the app and inviting their friends via a text message. From there, BarStock aggregates the favorite songs of all session party users and cultivates a playlist with all user preferences in mind.

BarStock utilizes the languages of Ruby, HTML, CSS, the web framework of Rails, and authentication via Spotify OAuth. The Spotify API is utilized to consume user playlist preference data.

#### [**_View BarStock in Production_**](https://barstock-backend.herokuapp.com)



FRONT END LINK


## Schema
[image](https://user-images.githubusercontent.com/42525195/56476372-d6c7eb00-6453-11e9-8a53-eedc34bafe28.png)

## Getting Started

To run BarStock on a local machine, navigate to the directory in which you would like the project to be located, then execute the following commands:

```
$ git clone git@github.com:MRKrog/barstock_backend.git
$ cd barstock_backend
$ bundle
$ rails g rspec:install
$ rails db:create
$ rails db:migrate
$ rails db:seed
```

### Running Tests

To run the test suite, execute the following command:
`rspec`.
<!-- add to this section if a background worker is implemented  -->


### Deployment

To view BarStock in development, execute the following command from the project directory: `rails s`. In a browser, visit `localhost:3000`, to view the application.

To view the application in production, from the project directory, execute the following commands:

```
$ createuser -s -r barstock_backend
$ RAILS_ENV=production rake db:{drop,create,migrate,seed}
$ rake assets:precompile
$ rails s -e production
```

## Endpoints


## Tools Utilized:

<!-- * <Continuous Integration> -->
* Faraday
* RSpec
* Capybara
* Pry
* Shoulda-Matchers
* Factory Bot
* Faker
* Trello
* SimpleCov
* Postman
* Circle CI
<!-- * <insert background workers> -->

## Known Issues


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
###### * [**_Agile Project Board_**](https://trello.com/b/jD2vXUGS/barstock)
###### * [**_Project Specifications_**](http://backend.turing.io/module4/projects/cross_pollination/cross_pollination_spec)
###### * [**_Project Rubric_**](http://backend.turing.io/module4/projects/cross_pollination/cross_pollination_rubric)

### Authors
* [Michael Krog](https://github.com/MRKrog)
* [Julia Marco](https://github.com/juliamarco)
* [Gabriel ](https://github.com/Inzurriaga)
* [Mackenzie Frey](https://github.com/Mackenzie-Frey)


### Acknowledgments
* [Dione Wilson](https://github.com/dionew1)
* [Cory Westerfield](https://github.com/corywest)
* [David Whitaker]()
* [Will Mitchell]()
