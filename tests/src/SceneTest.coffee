SceneTest = Class.create Scene,
	initialize: ->
		Scene.call @

		@time = new Time @, GAME_FPS

		lab = new Label()
		lab.text = 'Hello World.'
		lab.textAlign = 'center'
		lab.font = '30px Meiryo'
		lab.width = GAME_WIDTH
		@addChild lab

		@debugBox = new DebugBox @

	onenterframe: ->
		@debugBox.addText 'FPS : ' + @time.averageFps
		@debugBox.addText 'TEST' + @age

		@debugBox.addText 'TESTAAAAAAAAAAAAAAAAAAAAAAAA'
