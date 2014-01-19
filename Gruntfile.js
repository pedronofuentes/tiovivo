module.exports = function(grunt) {
    'use strict';

    grunt.initConfig({
        jshint: {
            options: {
                jshintrc: '.jshintrc'
            },
            all: [
                'Gruntfile.js'
            ]
        },
        coffee: {
            compile: {
                expand: true,
                flatten: true,
                cwd: 'src/coffee',
                src: ['*.coffee'],
                dest: 'src/js',
                ext: '.js'
            }
        },
        watch: {
            js: {
                files: [
                    '<%= jshint.all %>'
                ],
                tasks: ['jshint']
            },
            coffee: {
                files: [
                    'src/coffee/**/*.coffee'
                ],
                tasks: ['coffee']
            }
        }
    });

    grunt.loadNpmTasks('grunt-contrib-jshint');
    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-watch');
};
