fs = require 'fs'

module.exports = (grunt) ->
  grunt.initConfig

    clean:
      frontend:
        src: 'frontend/build'
      backend:
        src: 'backend/build'

    coffee:
      frontend:
        expand: true
        cwd: 'frontend/src/coffee'
        src: ['**/*.coffee','!_*','!**/_*.coffee']
        dest: 'frontend/build/js'
        ext: '.js'

    copy:
      frontend:
        expand: true
        cwd: 'frontend/src/static'
        src: ['**']
        dest: 'frontend/build/'
      frontend_js:
        expand: true
        cwd: 'frontend/src/js'
        src: ['**']
        dest: 'frontend/build/js'
      frontend_fonts:
        expand: true
        cwd: 'frontend/src/fonts'
        src: ['**']
        dest: 'frontend/build/fonts'
      frontend_css:
        expand: true
        cwd: 'frontend/src/style'
        src: ['*.css', '*.map']
        dest: 'frontend/build/css'
      frontend_images:
        expand: true
        cwd: 'frontend/src/images'
        src: ['*.*']
        dest: 'frontend/build/images'
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
      frontend:
        app: ['frontend/src/coffee/**/*.coffee']
        options:
          max_line_length:
            level: 'ignore'
          indentation:
            level: 'ignore'
      backend:
        app: ['backend/src/**/*.coffee']
        options:
          max_line_length:
            level: 'ignore'
          indentation:
            level: 'ignore'

    watch:
      frontend:
        files: ['frontend/src/coffee/**/*.coffee']
        tasks: ['coffeelint:frontend','coffee:frontend']
      frontend_static:
        files: ['frontend/src/static/**/*']
        tasks: ['copy:frontend']
      frontend_style:
        files: ['frontend/src/style/**/*.styl']
        tasks: ['stylus:frontend']
      frontend_js:
        files: ['frontend/src/js/**']
        tasks: ['copy:frontend_js']
      frontend_css:
        files: ['frontend/src/style/*.css', 'frontend/src/style/*.map']
        tasks: ['copy:frontend_css']
      frontend_images:
        files: ['frontend/src/images/**']
        tasks: ['copy:frontend_images']
      frontend_fonts:
          files: ['frontend/src/fonts/**/*']
          tasks: ['copy:frontend_fonts']
      backend:
        files: ['backend/src/**']
        tasks: ['coffeelint:backend','copy:backend']

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-copy'

  grunt.registerTask 'default', ['coffeelint', 'copy', 'coffee', 'watch']

