###
# DebugBox class
#
# @features
# - show Average FPS
# - output debug log
###
enchant.next.DebugBox = enchant.Class.create enchant.Group,
	initialize: (scene) ->
		enchant.Group.call(@)
		@padding = 10
		@font = "13px Consolas, 'Courier New', monospace"
		@permanentText = []

		@text = new enchant.Label()
		@width = scene.width
		@text.width = @width - @padding
		@text.y = @padding
		@text.textAlign = "right"
		@text.color = "#eee"
		@text.font = @font

		@bg = new enchant.Entity()
		@bg.backgroundColor = "rgba(0,0,0,.5)"
		@bg.width = 0
		@bg.height = 0

		@bgw = new enchant.Entity()
		@bgw.backgroundColor = "rgba(255,255,255,.3)"
		@bgw.width = 0
		@bgw.height = 0

		@addChild @bgw
		@addChild @bg
		@addChild @text

		scene.addChild @

		@time = enchant.next.Time.singleton()
		return

	addPermanentText: (text) ->
		@permanentText.push text
		return

	onenterframe: ->
		t = "FPS : " + @time.averageFps
		if @permanentText.length > 0
			for perm in @permanentText
				t += "<br>" + perm
		@text.text = t
		@permanentText = []

		w = @text._boundWidth + (@padding * 2)
		@bg.x = @width - w
		@bg.width = w
		@bg.height = @text._boundHeight + (@padding * 2)

		@bgw.x = @width - w
		@bgw.width = w
		@bgw.height = @text._boundHeight + (@padding * 2)
		return

enchant.next.DebugBox.singleton = (scene = null) ->
	if scene
		enchant.next.DebugBox._instance = new enchant.next.DebugBox(scene)

	if !enchant.next.DebugBox._instance?
		throw 'You need to singleton with scene first.'

	return enchant.next.DebugBox._instance
