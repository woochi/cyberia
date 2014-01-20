Cyberia 2020
============

This is the promotional site and in-game companion app for the Cyberia live roleplaying game organized in Rovaniemi 12.4.2014. The game is set in the world of cyberpunk. The production application is available at [www.cyberia2020.com](www.cyberia2020.com).

## Dependencies and Stack

 - Node.js / Express.js
 - Grunt
 - CoffeeScript
 - Backbone.js / Backbone.Marionette
 - Sass / Compass

## Development

The application is developed as a standard [Express.js](http://expressjs.com/) application. The backend provides a socket endpoint for the client application for syncing models and other real-time communication.

The client-side app is a single-page CoffeeScript app built upon [Backbone.js](http://backbonejs.org/) and [Backbone.Marionette](http://marionettejs.com/).

### Running development server

You can start the development server simply by running:

    grunt

Grunt handles compilation of assets and running of the development server. The project also uses Grunt's watch and livereload functionality in development environments.

## Deploying

The project can be deployed to production with Capistrano:

    cap production deploy

The deployment script compiles and minifies production assets once and then starts or restarts the production server through Upstart.
