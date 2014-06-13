###
# Vector class
#
# @features
# - keeps X and Y coordinate
# - useful static methods
# - calculate vector something
#
###
enchant.next.Vector = enchant.Class.create
	initialize: (x, y) ->
		@_x = x
		@_y = y
		@_radian = Math.atan2(@_y, @_x)
		@_degree = enchant.next.Vector.getDegree @_radian
		return

	x:
		get: -> @_x
		set: (x) ->
			@_x = x
			@_isDirtyRad = true
			@_isDirtyDeg = true

	y:
		get: -> @_y
		set: (y) ->
			@_y = y
			@_isDirtyRad = true
			@_isDirtyDeg = true

	radian: ->
		if @_isDirtyRad
			@_radian = Math.atan2(@_x, @_y)
			@_isDirtyRad = false
		@_radian

	degree: ->
		if @_isDirtyDeg
			@_degree = enchant.next.Vector.getDegree @radian
			@_isDirtyDeg = false
		@_degree

# Class Method
enchant.next.Vector.toRad = 0.017453292
enchant.next.Vector.getRadian = (degree) ->
	return degree * 0.017453292

enchant.next.Vector.toDeg = 57.29577951
enchant.next.Vector.getDegree = (radian) ->
	return radian * 57.29577951
