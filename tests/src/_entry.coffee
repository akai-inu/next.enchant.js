enchant('next')

GAME_WIDTH = 854
GAME_HEIGHT = 480
GAME_FPS = 20

window.onload = ->
	game = new Game GAME_WIDTH, GAME_HEIGHT
	game.fps = GAME_FPS
	game.onload = ->
		game.replaceScene new SceneTest()
	game.start()
