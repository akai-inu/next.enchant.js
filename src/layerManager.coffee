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
		@layers = []
		return
	addLayer: (layer) ->
		@layers.push layer
