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
	initialize: (fps, updateInterval) ->
		enchant.Node.call @
		@fps = fps ? 30 # target FPS
		@updateInterval = updateInterval ? 0.5 # Average FPS Interval(sec)
		@startTime = performance.now() # Class start base time
		@now = 0.0 # total elapsed ms(exact)
		@prevTime = 0.0 # prev frame time
		@targetElapsed = Math.floor(1000.0 / fps) + 1

		@frame = 0 # elapsed Frames
		@elapsedms = 0
		@elapsedsec = 0.0
		@isSlowly = false

		# calculate fps by Simple Moving Average
		@elapsedArray = []
		@averageFps = 0
		@totalElapsed = 0
		@totalElapsedms = 0
		@totalElapsedsec = 0.0

		@onenterframe()
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
		@elapsedArray.push Math.round @elapsedms
		@totalElapsed += Math.round @elapsedms

		# delete old data
		if @elapsedArray.length > @fps
			@totalElapsed -= @elapsedArray.shift()

		# get average FPS at 0.5 sec interval
		if @frame % (@fps * @updateInterval) == 0 && @elapsedArray.length > 0
			@averageFps = (1000 / (@totalElapsed / @elapsedArray.length)).toFixed 3

		return
	now: ->
		@now
