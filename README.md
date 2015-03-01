SignUps
===================

Project
-------------------
Connect a user signing up within the app to the creation of Account and Opportunity objects in Salesforce. It uses Clearbit to populate company specific info based on the domain, then using the company name, and company legal name as fallbacks.

Utilized the following project specific gems:
- `gem 'clearbit'`
- `gem 'databasedotcom'`
- `gem 'bcrypt'`
- `gem 'sidekiq'`

As well as the following for deployment to Heroku:
- `gem 'unicorn'`
- `gem 'rails_12factor'`


App Features
-------------------
- A user can sign up for a trial membership.
- A session is created where the user can see their entered information and are notified that they will be contacted soon.
- As the user object is being created in postgresql, a call is made to Clearbit to get company metadata. That information is used to create a related company object.
- A subsequent call to Salesforce passes the user-entered and Clearbit-provided data to create Salesforce Account objects with corresponding Contact and Opportunity objects.

Future Directions
-------------------
- [x] Create a background worker using Sidekiq to execute the calls to Clearbit and Salesforce once the user object is created in postgresql. (This would allow a faster, tentative response to the user.)
- [ ] Add additional levels of data validation such as uniqueness of email, and password length.
 - [x] Validation for presence of user and company name.
 - [x] Validation for presence and uniqueness of user email.
 - [x] Flash error message display for user sign ups.
 - [ ] Flash error message display for user log in.
- [ ] Prevent duplicate Contact objects from being created in Salesforce. (I have already implemented this for Account objects, and the steps would be similar.)
- [ ] Add more robust error handling around api calls.
- [ ] Create custom Salesforce fields to store additional Clearbit metadata such as company logo and social media links.
- [ ] Add more front-end features such as styling and options such as type-ahead smart fields.
