###
# @fileOverview
# next.enchant.js v0.0.1 (2014/01/31)
# NEXT Engine for enchant.js
#
# @author akai_inu
#
# @require enchant.js v0.8.0 or later
#
# @features
# - Extended Scene Management
# - Game Objects
# - Collisions
# - Background Layers
#
# @usage
# [Activate]
#   // Activate with this plugin
#   enchant('next');
#
###

# It needs enchant.js
throw 'next.enchant.js needs enchant.js.' if not enchant

# It needs underscore.js
throw 'next.enchant.js needs underscore.js.' if not _

enchant.next = {}
