###
# Time class
#
# @features
# - keep frame elapsed time
# - get average fps
#
# @constructor
# fps = set Target FPS
# updateInterval = Update interval for average FPS
###
enchant.next.Time = enchant.Class.create enchant.Node,
	initialize: (scene, @fps = 30, @updateInterval = 0.5) ->
		enchant.Node.call @
		@startTime = performance.now() # Class start base time
		@now = 0.0 # total elapsed ms(exact)
		@prevTime = 0.0 # prev frame time
		@targetElapsed = Math.floor(1000.0 / fps) + 1

		@frame = 0 # elapsed Frames
		@elapsedms = 0
		@elapsedsec = 0.0
		@isSlowly = false

		# calculate fps by Simple Moving Average
		@avg = new enchant.next.SimpleMovingAverage fps
		@averageFps = 0
		@totalElapsedms = 0
		@totalElapsedsec = 0.0

		@onenterframe()

		scene.addChild @
		return



	onenterframe: ->
		@frame++
		@now = performance.now() - @startTime

		elapsed = @now - @prevTime
		@prevTime = @now

		@elapsedms = elapsed
		@elapsedsec = elapsed * 0.001
		@isSlowly = elapsed > @targetElapsed

		@totalElapsedms = Math.floor @now
		@totalElapsedsec = @totalElapsedms * 0.001
		@avg.add Math.round @elapsedms

		# update average FPS at updateInterval
		if @frame % Math.round(@fps * @updateInterval) is 0
			@averageFps = (1000 / @avg.getAverage()).toFixed 2

		return



	now: ->
		@now
