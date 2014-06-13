Math.clamp = (val, min, max) ->
	return if val > max then max else if val < min then min else val
