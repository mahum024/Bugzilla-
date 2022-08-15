# README
# Bugzilla (Bugs tracking system )
Its a bug tracking system where an admin can add the projects and assign it to develeopers and qa's, while the qa can add bugs to the project and
developers will resole the errors # Prerequisites
# Ruby version
ruby 2.7.0
* Rails version
5.2.8.1
* PostgreSQL version
psql (PostgreSQL) 14.4
# Basic use libraries installation
* sudo apt update
* sudo apt install unace unrar zip unzip p7zip-full p7zip-rar sharutils gnupg2 rar uudeview mpack arj cabextract file-roller
# Actual Development Setup
* sudo apt-get install curl git gitk
* curl -L get.rvm.io | bash -s stable
# Other dependencies
Ruby and rails is required to run this project. For installation you can follow the following link:
https://gist.github.com/ziaulrehman40/0e3afe55d5d1f93e5bfb02f5a117567c#rvm
# For installation of postgress installation
* sudo apt install postgresql pgadmin4
# Check out the repository

# Install dependencies
To install the dependencies run:
* bundle install or bundle
# Database creation and setting up
Run the following commands to create and setting up the database.
* bundle exec rake db:setup
# Database seeding
* bundle exec rails db:seed
# API keys and credentials
To Run the app credential file must contains credentials for following:
* cloudinary needs, cloud_name, api_key , api_secret
* For smtp configuration user_name, password are needed
To edit the credential file in vscode run following command:
* EDITOR="code --wait" rails credentials:edit
# Start the Rails server
You can start the rails server using the command given below.
* bundle exec rails s
And now you can visit the site with the URL http://localhost:3000
