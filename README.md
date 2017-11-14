# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

### Postgres
You need to have Postgresql installed and running on your machine. Easiest way:
    ```
    brew install postgres
    ```
then install the gui-client here (https://postgresapp.com/documentation/gui-tools.html)
remember to start postgres everytime you restart your machine.
### ImageMagick for image processing capabilities
  (http://www.imagemagick.org/)

  ```
  brew install libpng jpeg
  brew link libpng
  brew install imagemagick
  ```

  Ensure that Paperclip has access to it. On your command line, run which convert (one of the ImageMagick utilities).
  This will give you the path where that utility is installed. For example, it might return /usr/local/bin/convert.

  Then, in your environment config file, let Paperclip know to look there by adding that directory to its path.
  In development mode, you might add this line to **config/environments/development.rb)**:

  ```
  Paperclip.options[:command_path] = "/usr/local/bin/"
  ```
### Redis

* On OsX

    ```
    brew install redis
    redis-server
    ```
### Sidekiq

* On OsX - no need to do anything besides start Sidekiq after you finished all steps in this guide. Just do this in the repo:

  ```
  bundle exec sidekiq
  ```
### Database
* Database creation
    ```
    rake db:create
    rake db:migrate
    ````
* Database initialization
 `rake db:seed`
### Secrets
you need to have a .env file in the root of this repo.
it should have the following key-value pairs:
```
GOOGLE_CLIENT_ID='<Your Google Client Id>'
GOOGLE_CLIENT_SECRET='<Your Google Client Secret>'
AWS_ACCESS_KEY_ID='<Your AWS Access Key>'
AWS_SECRET_ACCESS_KEY='<Your AWS Secret Access Key>'
AWS_REGION='<your bucket location, i.e. "eu-central-1" for Frankfurt>'
S3_BUCKET_NAME='<Your permanent S3 Bucket Name>'
S3_TEMP_BUCKET_NAME='<Your temporary S3 Bucket Name (the one with expiration turned on)>'
PAYPAL_CLIENT_ID='<Your Paypal Client Id>'
PAYPAL_CLIENT_SECRET='<Your Paypal Client Secret>'
```
### Run the server
* run the rails server
```
bundle exec rails s
```
* start redis:
```
redis-server
```
* start sidekiq
```
bundle exec sidekiq
```
also, DO NOT forget to have postgres running!

