###
# SimpleMovingAverage class
#
# @features
# - get average int value from latest X data
###
enchant.next.SimpleMovingAverage = enchant.Class.create
	initialize: (@maxLength = 100) ->
		@reset()



	###
	# add new value
	###
	add: (val) ->
		val = Math.round val
		@_dataList.push val
		@_total += val

		if @_dataList.length > @maxLength
			remove = @_dataList.shift()
			@_total -= remove



	###
	# reset values
	###
	reset: ->
		@_dataList = []
		@_total = 0



	###
	# get average
	###
	getAverage: ->
		return 0 if @_dataList.length is 0
		return @_total / @_dataList.length
