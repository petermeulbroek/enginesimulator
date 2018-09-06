# README

A simple Rails API app that generates a random walk around a set
number, and delivers this on demand.  The app simulates a sensor that
delivers steady stream of data.  The sensor does not stream data as it
is generated, it just gives data already generated.


TODO :
1.  Add a parameter to allow a data pull 'since', as in
GET /stats?since='2018-01-01 12:00'
2.  work out deployment
3.  adjust output to only include timestamp and value
4.  rename endpoints to the below


Endpoints

GET /stats
GET /healthcheck


The app consists of two types of data: stats and health.  Stats
represents statistics generated over time.  The generation is
controlled by Settings in config/settings.yml.  These are:

## healthCreateFrequency: 5s

The freqency in which the healthchecks are generated.  Note that the
parameter should be a string in a form that rufus
(https://github.com/jmettraux/rufus-scheduler) understands.  E.g.,
'5s', '10m'

## statCreateFrequency: 11s

The frequency in which the stats are created. Note that the parameter
should be a string in a form that rufus
(https://github.com/jmettraux/rufus-scheduler) understands.  E.g.,
'5s', '10m'

## healthyInterval: 20

An engine can be unhealthy because it exceeds operating parameters, or
because the reporting stops.  healthyInterval measures the amount of
time without a stat before the monitor is reported as unhealthy


## engineMinRPMs: 0

An engine can be unhealthy if it exceeds operating parameters.  This
is the lower bound.

## engineMaxRPMs: 200

An engine can be unhealthy if it exceeds operating parameters.  This
is the upper bound.

## statRange: 6

statRange is the range of the random walk.  The next step is always
within this range.  e.g., with a range of 2, the next step is within
-1 to +1


# Structure

The app is based on two models

table stats
   time timestamp
   value float


table health
   time timestamp
   value boolean

and a controller method for both.


Values are generated asyncronously using Rufus.

# Bootstrapping
## system requirements
## install
## rake db:setup
## RAILS_ENV=productionrails s


# TODO
1.  create a new controller /queue
2.  create methods stop, restart
3.  move methods from Stats
4.  get production server working
5.  change responses depending on results of create action

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
