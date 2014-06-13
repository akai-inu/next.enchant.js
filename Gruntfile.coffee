module.exports = (grunt) ->
	grunt.initConfig
		pkg: grunt.file.readJSON 'package.json'
		path:
			app: __dirname
			src: '<%= path.app %>/src'
			build: '<%= path.app %>/build'
			distribusion: [
				'<%= path.app %>/../wa-wa-war/src/public/vendor/next.enchant.js'
			]

		coffee:
			options:
				bare: true
			default:
				files: [
					{ dest: '<%= path.build %>/next.enchant.js', src: '<%= path.src %>/*.coffee' }
				]

		uglify: [
			{ dest: '<%= path.build %>/next.enchant.min.js', src: '<%= path.build %>/next.enchant.js' }
		]

		copy:
			default:
				files: [
					{ dest: '<%= path.distribusion[0] %>', src: '<%= path.build %>/next.enchant.js' }
				]

	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-uglify'
	grunt.loadNpmTasks 'grunt-contrib-copy'

	grunt.registerTask 'default', [ 'coffee:default', 'uglify', 'copy:default' ]
