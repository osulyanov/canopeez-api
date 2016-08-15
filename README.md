Canopeez
========

GENERAL INSTRUCTIONS
 
 1. for each change to db, make the corresponding change to the active admin panel
 2. run tests! (bundle exec rspec spec/) before each push to make sure you havent broken anything (I will run the tests too)
 3. If you have access to heroku, run the migration after each push (wait 2 minutes for app to deploy automatically)
 3. UPDATE API documentation every time you make a change!

# Users' credentials

Admin: admin@example.com / 1q2w3e4r

User: user@example.com / 1q2w3e4r

# Deploy (only for test environments)

## Ruby installation

Ruby installation on **Ubuntu based** distibutions much more painless than under ReadHat based

It's better to use rbenv, in case of any issues see [rbenv/rbenv](https://github.com/rbenv/rbenv).

Then install Ruby 2.2.4

    rbenv install 2.2.4

Disable gem documentation auto installing

    echo 'gem: --no-document' >> ~/.gemrc

## Project installation

### Get code and modules

    git clone git@github.com:cracadumi/canopeez-api.git
    cd canopeez-api
    bundle install

If ``bundle install`` fails you probably need to install additional system dependancies manually (it depends on you default installed system packages like Node.js, kernel headers, libxml, etc.). After installing it run ``bundle install`` again until you will get message ``Your bundle is complete!``

### Prepare DB

    bundle exec rake db:migrate
    bundle exec rake db:seed
