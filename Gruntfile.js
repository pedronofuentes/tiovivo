module.exports = function(grunt) {
    'use strict';

    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),
        meta: {
            banner: '/* <%= pkg.name %> v<%= pkg.version %> - <%= grunt.template.today("yyyy/m/d") %>\n' +
              '   <%= pkg.homepage %>\n' +
              '   Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author %>' +
              ' - Licensed <%= pkg.license %> \n*/\n'
        },
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
        concat: {
            dist: {
                options: {
                    banner: '<%= meta.banner %>'
                },
                files: {
                    'dist/tiovivo.js': ['src/js/tiovivo.js']
                }
            }
        },
        uglify: {
            dist: {
                options: {
                    banner: '<%= meta.banner %>'
                },
                files: {
                    'dist/tiovivo.min.js': ['src/js/tiovivo.js']
                }
            }
        }
    });

    grunt.loadNpmTasks('grunt-contrib-jshint');
    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-contrib-concat');
    grunt.loadNpmTasks('grunt-contrib-uglify');

    grunt.registerTask('dist', ['coffee:src', 'concat:dist', 'uglify']);
};
