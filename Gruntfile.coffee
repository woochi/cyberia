module.exports = (grunt) ->

  coffeeify = require('coffeeify')
  # Load all grunt tasks
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)

  grunt.initConfig
    express:
      options:
        cmd: "coffee"
        port: 3000
      dev:
        options:
          script: "app.coffee"
          livereload: true
    sass:
      options:
        compass: true
      build:
        files:
          "build/assets/stylesheets/app.css": "assets/stylesheets/app.sass"
    browserify:
      build:
        files:
          "build/assets/javascripts/app.js": ["assets/javascripts/app.coffee"]
        options:
          transform: ["coffeeify"]
    watch:
      options:
        livereload: true
      sass:
        files: ["assets/stylesheets/**/*.sass", "assets/stylesheets/**/*.scss"]
        tasks: ["sass"]
      browserify:
        files: ["assets/javascripts/**/*.coffee"]
        tasks: ["browserify"]
      views:
        files: ["views/**/*.jade"]
        tasks: []

  grunt.registerTask "default", ["browserify", "sass", "express:dev", "watch"]
  grunt.registerTask "deploy", ["browserify", "sass"]
