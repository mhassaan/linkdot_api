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
  
  #### Request Parameters
  Parameter | Presence | Description
  --- | --- | ---
  user[emai] | required | User email address.
  user[password] | required | User password.
  picture[avatar] | required | Picture of the user. 
  tag_ids[0] | required | Array of tag ids, that represent user interest.
  
  ### Curl Request
  
  `
  curl -X POST -F "user[email]='random@mail.com" -F "user[password]=12345678" -F "tag_ids[0][]=1" -F"    picture[avatar]=@Path of local image" http://localhost:3000/users/sign_up
  `
  
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
  
  This end point signs in new user.
  
  ### HTTP Request
  
  `POST http://localhost:3000/users/sign_in`
  
  ### Request Perameters
  
  Parameter | Presence | Description
  --- | --- | ---|
  user[email] | required | User email address.
  user[password] | required | User Password
  
  ### Curl Request
  
  `curl -X POST -F "user[email]='jackie@mail.com" -F "user[password]=12345678" http://localhost:3000/users/sign_in`
  
  The above command returns a response like this: 
  
  ```
    {
      "user": {
          "id": 55,
          "email": "jackie@mail.com",
          "authentication_token": "xBysg6BptdYxZi2WPWsk",
          "picture": {
              "id": 51,
              "image": "http://localhost:3000/system/pictures/avatars/000/000/051/original/ns.jpg?1503684916"
          },
          "tags": [
              {
                  "name": "Digital Programming"
              }
          ]
              }
    }
    
  ```
  
+ **Sign Out:**
  
  This endpoint sign out login user.
  
  ### HTTP Request
  
  `DELETE http://localhost:3000/users/sign_out`
  
  ### Request Parameters
  
  Parameter | Presence | Description
  --- | --- | ---- |
  token | required | Sing in user's token.
  
  ### Curl Request
  
  `curl -X DELETE -H "Authorization: Token token=TOKEN OF SIGN IN USER" http://localhost:3000/users/sign_out`
  
  The above command returns a response like this.
  
  ```
  {"detail":"Sign Out Successfully."}
  
  ```
  
  
+ **Events:**
  
  #### Get all events
  
  This endpoint returns all events in the system.
  
  ### HTTP Request
  
  `GET http://localhost:3000/events`
  
  ### Request Parameters
  
  Parameter | Presence | Description 
  --- | --- | --- |
  token | required | Auth token of sign in user
  
  ### Curl Request
  
  `curl -H "Authorization: Token token=TOKEN OF SIGN IN USER" http://localhost:3000/events`
  
  The above command returns a json response like this: 
  
  ```
    {
    "events": [
        {
            "id": 7,
            "title": "Smart City Innovation",
            "address": "Alto University Finland",
            "city": "Helsenki",
            "state": "HL",
            "zip": "38100",
            "event_start_time": "02:00 AM",
            "event_end_time": "12:00 PM",
            "event_start_date": "09-12-2017",
            "event_end_date": "12-12-2017",
            "picture": {
                "id": 45,
                "image": "http://localhost:3000/system/pictures/avatars/000/000/045/original/19467565_717135315143212_2254025401790960972_o.jpg?1503409105"
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
        },
        {
            "id": 8,
            "title": "Trip to Ericson Lab",
            "address": "Ericson Labs.Inc",
            "city": "Helsenki",
            "state": "HL",
            "zip": "38100",
            "event_start_time": "02:00 AM",
            "event_end_time": "12:00 PM",
            "event_start_date": "09-12-2017",
            "event_end_date": "12-12-2017",
            "picture": {
                "id": 46,
                "image": "http://localhost:3000/system/pictures/avatars/000/000/046/original/calculatoe1955.jpg?1503410065"
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
    ]
  }
  ```
  
  

