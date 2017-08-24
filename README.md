# API Documentation

This documentation intends to give an overview of the Apis endpoints and the appropriate way to consume them using any client.

Getting started with linkdot_api
--------------------------------

### Prerequisites

You are going to need:

- **Linux or OSX**
- **Ruby version-2.4.0**
- **Rails version-5.0**
- **Bundler** - If Ruby is installed but the `budnle` command does not work, just run `gem install bundler` in a terminal.

### Getting Set Up

1. Fork this repository on Github.
2. Clone the forked repository to your hard drive using `git clone git@github.com:YOUR USERNAME/linkdot_api.git`
3. `cd linkdot_api`

```shell
bundle install 
rake db:create
rake db:migrate
rails s 
```

You can now see the apis up and running locally at http://localhost:3000. Whoa! Thats fast ;)

### Endpoints

We target to develop Api's for the following features in our project. Of course, we will be adding more as we move along with the scope of the project.

+ **Sign Up:**
  
  This end point creates new user. 
  
  #### HTTP Request
  `POST http://localhost:3000/users/sign_up`
  
  #### Post Parameters
  Parameter | Presence | Description
  --- | --- | ---
  user[emai] | required | User email address.
  user[password] | required | User password.
  picture[avatar] | required | Picture of the user. 
  tag_ids[0] | required | Array of tag ids, that represent user interest.
  
  The above command returns a json response like this: 
  
```
  
  {
    "user": {
        "id": 51,
        "email": "josh@mail.com",
        "picture": {
            "id": 47,
            "image": "http://localhost:3000/system/pictures/avatars/000/000/047/original/pin.jpg?1503499504"
        },
        "tags": [
            {
                "name": "Digital Programming"
            },
            {
                "name": "Digital Programming"
            },
            {
                "name": "Meta Programming"
            }
        ]
    }
 }

```
  
+ **Sign In:** 

+ **Sign Out:**

+ **Events:**


Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
