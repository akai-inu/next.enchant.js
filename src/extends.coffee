if !Math.clamp
	Math.clamp = (val, min, max) ->
		if val > max then max else if val < min then min else val

if !Math.within
	Math.within = (val, min, max) ->
		min <= val and val <= max

if !Math.without
	Math.without = (val, min, max) ->
		val < min or max < val

if !Math.lerp
	Math.lerp = (val, start, end) ->
		(end - start) * Math.clamp(val, 0.0, 1.0) + start

if !Math.toDegree
	(->
		toDegreeVal = Math.PI / 180.0
		Math.toDegree (val) ->
			val * toDegreeVal
	)()

if !Math.toRadian
	(->
		toRadianVal = 180.0 / Math.PI
		Math.toRadian = (val) ->
			val * toRadianVal
	)()

if !Math.distance
	Math.distance = (x1, y1, x2, y2) ->
		x = x1 - x2
		y = y1 - y2
		Math.sqrt x * x + y * y

	Math.distanceObj = (p1, p2) ->
		Math.distance p1.x, p1.y, p2.x, p2.y

if !Math.distance2
	Math.distance2 = (x1, y1, x2, y2) ->
		x = x1 - x2
		y = y1 - y2
		x * x + y * y

	Math.distance2Obj = (p1, p2) ->
		Math.distance2 p1.x, p1.y, p2.x, p2.y

MOUSEX = 0
MOUSEY = 0
document.addEventListener 'load', ->
	document.getElementById('enchant-stage').addEventListener 'mousemove', (e) ->
		MOUSEX = e.pageX
		MOUSEY = e.pageY
