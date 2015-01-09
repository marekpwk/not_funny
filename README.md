[ ![Codeship Status for marekpwk/not_funny](https://codeship.io/projects/c9871000-2989-0132-e154-56d4646563ad/status)](https://codeship.io/projects/38097)

NOT FUNNY
=========


 Web application where users can create their own memes, share them on social networks, comment on them and vote on for popularity. Users can also create memes through MMS messages, and be notified via text message when memes are approved. Application also features Admin panel, where users and memes can be managed.

 Live Demo: [notfunny.herokuapp.com](http://notfunny.herokuapp.com/)

#Setup

 Clone this repo to your local machine.

   `bundle install`

   Create database and run migrations:


   `rake db:create`

   `rake db:migrate`

   `rake db:seed` to populate with sample data
   
   Or just run all three commands together with: `rake db:yolo`

   And then start the server

   `rails s`

##Storage

   In production this application uses AWS S3 for storage, so you need an [AWS S3](http://aws.amazon.com/s3/) account and following environment variables setup with AWS S3 info :

   `S3_BUCKET_NAME` - bucket name

   `S3_KEY` - access key id

   `S3_SECRET` - secret access key

##CloudFront

   This application also uses AWS CloudFront to serve assets and images faster, so to make this work you need an [AWS CloudFront](http://aws.amazon.com/cloudfront/) account and setup two CloudFront distributions, one to serve assets and the another one to serve images(memes), following environment variables need to be setup:
   
   `ASSET_HOST` - CloudFront address for assets

   `CARRIER_ASSET_HOST` - CloudFront address for images

   `DOMAIN` - your domain name

##Create memes from your cellphone

For creating Memes from MMS messages this app uses Twilio services, to make this work you need [Twilio](https://www.twilio.com/) account, and the following environment variables setup:

`TWILIO_ACCOUNT_SID` - Twilio Account SID

`TWILIO_AUTH_TOKEN` - Twilio Auth Token

`TWILIO_NUMBER` - Twilio number

`MY_NUMBER` - Phone number confirmed with Twilio(I am using trial account, so I can send and receive messages just from one number)

`MMS_USER` - user id for mms user(currently all incoming MMS are asigned to one user)

On Twilio website in settings under Messaging, set url to `your_app_address/twilio/inbound` and for HTTP METHOD select `POST`

