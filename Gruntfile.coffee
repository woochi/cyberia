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
        bundleExec: true
      build:
        files:
          "build/assets/stylesheets/app.css": "assets/stylesheets/app.sass"
    browserify:
      build:
        files:
          "build/assets/javascripts/app.js": ["assets/javascripts/app.coffee"]
        options:
          transform: ["coffeeify"]
          shim:
            bacon:
              path: "assets/javascripts/libs/bacon.min.js"
              exports: "Bacon"
            d3:
              path: "assets/javascripts/libs/d3.min.js"
              exports: "d3"
    copy:
      build:
        files: [
          expand: true
          flatten: true
          src: ["assets/javascripts/libs/*.js"]
          dest: "build/assets/javascripts"
          filter: "isFile"
        ]
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

  grunt.registerTask "default", ["browserify", "copy", "sass", "express:dev", "watch"]
  grunt.registerTask "deploy", ["browserify", "copy", "sass"]
