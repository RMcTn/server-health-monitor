# README

async adapter for action cable not working for development any more, requires redis in dev now

PostgreSQL

There's a task that resets the demo user (reset_demo_user.rake). Ideally scheduled to run daily or something
It expects that /failingserver is routed to DemoController#failing, so that a demo of the live server health update can be seen
The task wipes out all organisations (and therefore servers) that the demo user is apart of. If any org was to add the demo user, it will be wiped
If in prod, the APP_URL env var should hold the url to the server, so that /failingserver can be pinged automatically

This README would normally document whatever steps are necessary to get the
application up and running.

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
