# README
Sample project that enables users capture their income and expenditure records within selected intervals.

Things you may want to cover:

* Ruby version
  - ruby 3.0.0
  - rails 7.0.5

* System dependencies
  - listed in `Gemfile`

* Database creation
  - rails db:create db:migrate

* How to run the test suite
  - bundle exec rspec

* Services (job queues, cache servers, search engines, etc.)
  - Sidekiq

* General set-up
  - after clone, cd in directory and run `bundle install`
  - `rails db:create db:migrate`
  - start up postgres and redis servers
  - Add env variables and values (example in `.env.example`)
  - run `rails s` (starts up server locally on port 3001)
  - Also run `bundle exec sidekiq` on anothe tab of the same directory

API Doc: [Link](https://documenter.getpostman.com/view/15327990/2s93zE3L2J)
