###
# DebugBox class
#
# @features
# - output debug log
###
enchant.next.DebugBox = enchant.Class.create enchant.Group,
	initialize: (scene) ->
		enchant.Group.call(@)
		self = @
		padding = 5
		@textList = []
		@width = scene.width

		text = new enchant.Label()
		text.width = @width - padding * 2
		text.x = padding
		text.y = padding
		text.textAlign = "right"
		text.color = "#eee"
		text.font = "13px Consolas, 'Courier New', monospace"
		text.onenterframe = ->
			t = self.textList.join('<br>')
			self.clearText()
			@text = t if @text isnt t

		bg = new enchant.Entity()
		bg.backgroundColor = "rgba(0,0,0,.5)"
		bg.width = 0
		bg.height = 0
		bg.onenterframe = ->
			w = text._boundWidth + (padding * 2)
			w = Math.max w, Math.floor scene.width * 0.2
			h = text._boundHeight + (padding * 2)
			h = Math.max h, Math.floor scene.height * 0.2
			@x = scene.width - w
			@width = w
			@height = h

		@addChild bg
		@addChild text

		scene.addChild @
		return

	addText: (text) ->
		@textList.push text
		return

	clearText: ->
		@textList = []
		return
