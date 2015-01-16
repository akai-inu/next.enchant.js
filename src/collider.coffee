enchant.next.Collider = enchant.Class.create enchant.Entity,
	initialize: (@parent, @collideType = enchant.next.Collider.TYPE_DEFAULT) ->
		enchant.Entity.call @
		@enabled = true
		@width = @parent.width
		@height = @parent.height

		if DEBUG? and DEBUG
			switch @collideType
				when enchant.next.Collider.TYPE_RECT
					# 四角形の判定を描画
					surface = new Surface @width, @height
					c = surface.context
					c.beginPath()
					c.rect 0, 0, @width, @height
					x = 0
					y = 0
					break
				else
					# 円の判定を描画
					radius = Math.max(@width, @height) / 2
					surface = new Surface radius * 2, radius * 2
					c = surface.context
					c.beginPath()
					c.arc radius, radius, radius - 2, 0, Math.PI * 2
					x = @width / 2 - radius
					y = @height / 2 - radius
					break
			c.strokeStyle = "#111"
			c.lineWidth = 1
			c.stroke()

			@line = new enchant.Sprite surface.width, surface.height
			@line.image = surface
			@line.x = x
			@line.y = y
			@parent.addChild @line

	###
	# It calls when detected collision
	#
	# @return		bool		delete flag
	###
	onCollide: (against) ->
		false

	###
	# Get it will delete in this frame
	#
	# @return		bool		delete flag
	###
	willDelete: ->
		false

enchant.next.Collider.TYPE_RECT = 'rect'
enchant.next.Collider.TYPE_ARC = 'arc'
enchant.next.Collider.TYPE_DEFAULT = enchant.next.Collider.TYPE_ARC
