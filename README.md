# Puresong - A lightweight application using Pure CSS and Sinatra

A lightweight Sinatra application that uses the Pure CSS modules  [Pure.css](http://purecss.io/) to provide responsive screen handling.

![Puresong screenshot](http://vizi.ca/images/poplite.png)

## Audience

This article is intended for people familiar with Sinatra and SQLite who want to use Pure CSS to build responsive applications.

The sample application builds a new interface around a sample application that is described in Jump Start Sinatra by Darren Jones [Sitepoint website](http://www.sitepoint.com/store/jump-start-sinatra/).

## Requirements

* `ruby` >= 1.9 (application was built and tested with Ruby 1.9.3).

## Installation

Download the application to your local desktop. 

Install the required gems (see the Gemfile),

## Usage

The application run in development mode with 'ruby app.rb' command.

The application can also be tested as a rack application with the 'rackup' command.

## What is Purelite?
The Purelite mini-stack includes the following:

* One page application built with Sinatra and ERB
* Sqlite3 with Sequel
* Pure.css javascripts
* Capture of visitor infomation and emailing with Mandrill

## Features
The features shown in the application include:

* Responsive screen using Pure.css capabilities
* Pure.css functions include: top and side menus, grid structures, headers and footers
* A webpage that demonstrates a small SQLlite application used to demonstrate menu and button behaviour 
* A webpage that demonstrates a screen to capture contact information from a visitor. This information is send to the website administrator using the Mandrill email application.
* This project is designed to show the capabilities of Pure.css interacting with a small Sinatra SQLite application. It is not intended for production use.

## License

This code is dedicated to the public domain to the maximum extent permitted by applicable law, pursuant to CC0 http://creativecommons.org/publicdomain/zero/1.0/

Please reference the copyright restrictions that may apply to the sample Sinatra SQLite application as published in 'Jump Start Sinatra'.
