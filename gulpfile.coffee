gulp = require 'gulp'
coffee = require 'gulp-coffee'
concat = require 'gulp-concat'
rimraf = require 'rimraf'
nodeStatic = require 'node-static'
http = require 'http'

BASE_PATH = __dirname
TEST_PORT = 5790

gulp.task 'default', ['clean'], ->
	# default compile
	gulp.src [BASE_PATH + '/src/_header.coffee', BASE_PATH + '/src/**/*.coffee']
		.pipe concat 'next.enchant.js'
		.pipe coffee {bare: true}
		.pipe gulp.dest BASE_PATH + '/build'

gulp.task 'test', [], ->
	# test compile
	gulp.src [BASE_PATH + '/tests/src/_entry.coffee', BASE_PATH + '/tests/src/*.coffee']
		.pipe concat 'test.js'
		.pipe coffee {bare: true}
		.pipe gulp.dest BASE_PATH + '/tests/build'

gulp.task 'serve-test', ['test'], (next) ->
	# serve test server
	file = new nodeStatic.Server BASE_PATH + '/tests/'

	server = http.createServer (req, res) ->
		listener = req.addListener 'end', ->
			file.serve req, res
		listener.resume()

	server.listen TEST_PORT
	console.log 'serve test server on port:' + TEST_PORT
	next()

gulp.task 'watch', ['default'], (next) ->
	# watch changes
	gulp.watch [BASE_PATH + '/src/**/*'], ['default']
	gulp.watch [BASE_PATH + '/tests/src/**/*'], ['test']
	next()

gulp.task 'watch-test', ['watch', 'serve-test'], ->
	# watch changes and serving test

gulp.task 'clean', [], (next) ->
	# clean bulid files
	rimraf BASE_PATH + '/build', next
