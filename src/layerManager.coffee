###
# Layer Manager class
#
# @features
# - manages 2D scrollable layers
#
###
enchant.next.LayerManager = enchant.Class.create ->
	initialize: (scene) ->
		@parentScene = scene
		scene.addChild @
		@layers = []
		return
	addLayer: (layer) ->
		@layers.push layer

enchant.next.LayerManager.singleton = (scene = null) ->
	if scene
		enchant.next.LayerManager._instance = new enchant.next.LayerManager(scene)

	if !enchant.next.LayerManager._instance?
		throw "You need to singleton with scene first."

	return enchant.next.LayerManager._instance
