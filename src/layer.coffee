###
# Layer class
#
# @features
# - represents 1 layer in world
#
# @usage
#
###
enchant.next.Layer = enchant.Class.create enchant.Group, ->
	initialize: (@distance) ->
		enchant.Group.call @
		return
