module.exports = function(grunt) {
    'use strict';

    grunt.initConfig({
        source: {
            src: [
                'src/coffee/*.coffee'
            ],
            spec: [
                'spec/coffee/*.coffee'
            ]
        },
        jshint: {
            options: {
                jshintrc: '.jshintrc'
            },
            all: [
                'Gruntfile.js'
            ]
        },
        coffee: {
            src: {
                files: {
                    'src/js/tiovivo.js': '<%= source.src %>'
                },
                options: {
                    bare: true
                }
            },
            spec: {
                files: {
                    'spec/js/tiovivoSpec.js': '<%= source.spec %>'
                },
                options: {
                    bare: true
                }
            }
        },
        watch: {
            js: {
                files: [
                    '<%= jshint.all %>'
                ],
                tasks: ['jshint']
            },
            src: {
                files: ['<%= source.src %>'],
                tasks: ['coffee:src'],
                options: {
                    livereload: true
                }
            },
            spec: {
                files: ['<%= source.spec %>'],
                tasks: ['coffee:spec'],
                options: {
                    livereload: true
                }
            }
        },
    });

    grunt.loadNpmTasks('grunt-contrib-jshint');
    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-watch');
};
