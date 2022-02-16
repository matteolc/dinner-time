# Dinner Time

Live on [Heroku](https://boiling-shore-95487.herokuapp.com/)

- Ruby 3 and Rails 6.1.4.4
- React 17 (`react-rails`)
- Typescript

## User stories

- A user can browse through all recipes
- A user can search and browse recipes by searching for one or more ingredients

## Technical details

- Due to the basic requirements of the application I have chosen not to create a JSON API endpoint and a Rect component with `fetch`. Instead the `recipes` controller responds with the recipes page `HTML` or `JSON` (if requested as `/recipes.json?...`)
- Filtering is only done on the `ingredients` attribute of the recipes
- Accents do not impact search results
- Memory cache is used to speed-up page load times
- The classic `form GET` design brings state-less functional components and history navigation (a user can navigate back and forth with browser history without loosing state)
- Basic styles have been added by adapting existing ones I use

## Configuration

### Creating the app

```
> docker run -it --volume=/src/dinner-time:/app --volume=/src/dinner-time/bundle:/usr/local/bundle ruby:3-slim /bin/bash
# apt-get install -y wget gnupg git build-essential libpq-dev
# echo "deb http://apt.postgresql.org/pub/repos/apt/ bullseye-pgdg main" | tee /etc/apt/sources.list.d/postgresql.list
# wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
# apt-get update
# apt-get install -y postgresql-client-14
# echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
# wget --quiet -O - https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
# apt-get update
# apt-get install -y yarn
# gem install rails -v 6.1.4.4
# rails new app -d postgresql --webpack=react --skip-action-mailer --skip-action-mailbox --skip-action-text --skip-active-job --skip-active-storage --skip-action-cable --skip-test
# cd app
# bundle add react-rails pagy pragmatic_tokenizer
# bundle add annotate --group=development
# bundle add factory_bot_rails rspec-rails --group=development,test
# bundle add faker --group=test
# bundle exec rails g annotate:install
# bundle exec rails g rspec:install
# yarn add lodash uglifyjs-webpack-plugin
# yarn add @types/lodash @types/react @types/react-dom --dev
# rails webpacker:install:typescript
# rails webpacker:install:react
# rails generate react:install
# exit
```

### Main changes

- Added `docker-compose.yml` and `Dockerfile`
- Started the app with `docker-compose up -d`
- Updated `config/database.yml`
- Updated `config/application.rb`
- Updated `tsconfig.json`
- Added `config/initializers/pagy.rb`
- Created migrations `rails g migration ConfigureTextSearch` and `rails g migration CreateRecipes ...` and `rails g migration IndexRecipes`
- Updated migration files
- Created and migrated the database
- Got the data: `cd db && wget https://d1sf7nqdl8wqk.cloudfront.net/recipes.json.gz && gzip -dc recipes.json.gz > recipes.json`
- Fixed the JSON (...)
- Created a recipe model in `app/models/recipe.rb`
- Imported JSON in db with `db/seeds.rb`
- Created a recipe controller in `app/controllers/recipe_controller.rb`
- Updated `config/routes.rb`
- Created stylesheets in `app/assets/stylesheets`
- Created a recipe layout in `views/layouts/recipes.html.erb`
- Created recipe listing views in `views/recipes`
- Created React components in `app/javascript/packs/components`
- Created tests

### Getting ready for production

- Added memory cache store in `config/production.rb`
- Added minification in `config/webpack/production.js`

### Database creation

```
> bundle exec rake db:create
> bundle exec rake db:migrate
```

### Database initialization

```
> bundle exec rake db:seed
```

## Running tests

```
> bundle exec rspec
```

## Services

A PostgreSQL service is required to use this application.

## Deployment

The project has been deployed to Heroku.

- Renamed `master` branch to `main`: `git branch -m master main`
- Created an Heroku app: `heroku create`
- Added the Heroku Postgres add-on
- Pushed to Heroku: `git push heroku main`
- Migrated the database: `heroku run rake db:migrate`
- Seeded the database: `heroku run rake db:seed`
