fs = require 'fs'

module.exports = (grunt) ->
  grunt.initConfig

    clean:
      main:
        src: 'node_modules'
      backend:
        src: 'backend/build'

    copy:
      backend:
        expand: true
        cwd: 'backend/src'
        src: ['**']
        options:
          mode: true
        dest: 'backend/build'
      defaultignore:
        expand: true
        cwd: './'
        src: ['defaultignore']
        options:
          mode: true
        dest: 'node_modules/replace'

    coffeelint:
      backend:
        app: ['backend/src/**/*.coffee']
        options:
          max_line_length:
            level: 'ignore'
          indentation:
            level: 'ignore'

    watch:
      backend:
        files: ['backend/src/**']
        tasks: ['coffeelint:backend','copy:backend']

  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-copy'

  grunt.registerTask 'default', ['coffeelint', 'copy', 'watch']

