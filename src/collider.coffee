enchant.next.Collider = enchant.Class.create enchant.Entity,
	initialize: (@parent, @name, @collideType = "arc", @onCollide = -> false) ->
		@enabled = true
		@willDelete = false
		@width = @parent.width
		@height = @parent.height

		if DEBUG
			switch @collideType
				when "rect"
					surface = new Surface @width, @height
					c = surface.context
					c.beginPath()
					c.rect 0, 0, @width, @height
					break
				else
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

			@line = new Sprite surface.width, surface.height
			@line.image = surface
			@line.x = x
			@line.y = y
			@parent.addChild @line
