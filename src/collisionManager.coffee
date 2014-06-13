enchant.next.CollisionManager = enchant.Class.create
	initialize: ->
		@colliders = []
		return @

	addCollider: (collider) ->
		@colliders.push collider
		return @

	removeCollider: (collider) ->
		i = 0
		for c in @colliders
			if c is collider
				@colliders.splice i, 1
				return true
			i++
		return false

	onenterframe: ->
		deleteArray = []

		for obj1,i in @colliders
			j = i + 1
			while j++ < @colliders.length
				obj2 = @colliders[j]

				if obj1.name isnt obj2.name && obj1.enabled && obj2.enabled && !obj1.willDelete && !obj2.willDelete && @hasCollide obj1, obj2
					deleteArray.push obj1 if obj1.onCollide obj2
					deleteArray.push obj2 if obj2.onCollide obj1

		for i in deleteArray
			@removeCollider i

		return @

	hasCollide: (obj1, obj2) ->
		if obj1.collideType == obj2.collideType == "rect"
			return obj1.intersect obj2
		else if obj1.collideType isnt obj2.collideType
			if obj1.collideType == "rect"
				return @collideRectArc obj1, obj2
			else
				return @collideRectArc obj2, obj1
		else
			return obj1.within obj2

	collideRectArc: (rect, arc) ->
		ax = rect.x + rect._offsetX
		ay = rect.y + rect._offsetY
		a = [
			{x: ax, y: ay}
			{x: ax + rect.width, y: ay}
			{x: ax, y: ay + rect.height}
			{x: ax + rect.width, y: ay + rect.height}
		]
		b =
			x: arc.x + arc._offsetX
			y: arc.y + arc._offsetY
			r: Math.max(arc.width, arc.height) / 2

		return @_collideRectArcFirst(a, b) && @_collideRectArcSecond(a, b) && @_collideRectArcThird(a, b)

	_collideRectArcFirst: (a, b) ->
		###
		# collide with end point and arc
		###
		for i in [0...4]
			return true if @collidePointArc a[i].x, a[i].y, b.x, b.y, b.r
		return false

	_collideRectArcSecond: (a, b) ->
		###
		# collide with line and arc
		###
		n = [ [0, 1, 3, 2], [1, 3, 2, 0] ]
		for i in [0...4]
			pq = @getVector a[ (n[0][i]) ], a[ (n[1][i]) ]
			pm = @getVector a[ (n[0][i]) ], b

			dot @getDot pq, pm
			pqd2 = @getLength2 pq
			pmd2 = @getLength2 pm

			k = dot / pqd2

			continue if k < 0 || 1 < k

			phd2 = (dot * dot) / pqd2
			d2 = pmd2 - phd2

			return true if d2 < b.r * b.r

		return false

	_collideRectArcThird: (a, b) ->
		###
		# intersect arc
		###
		for i in [0...2]
			pp = @getVector a[ i*3 ], a[ 1+i ]
			pm = @getVector a[ i*3 ], b

			dot = @getDot pp, pm
			cross = @getCross pp, pm

			theta[i] = Math.atan2 cross, dot

		return 0 <= theta[0] && theta[0] <= Math.PI / 2 && 0 <= theta[1] && theta[1] <= Math.PI / 2

	collidePointArc: (ax, ay, _bx, _by, r) ->
		dx = _bx - ax
		dy = _by - ay
		return ((dx * dx) + (dy * dy)) < (r * r)

	getVector: (ax, ay, _bx, _by) ->
		{x: _bx - ax, y: _by - ay}

	getDot: (a, b) ->
		a.x * b.x + a.y * b.y

	getCross: (a, b) ->
		a.x * b.y - a.y * b.x

	getLength2: (a) ->
		@getDot a, a
