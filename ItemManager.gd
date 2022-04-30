extends Node

enum item_ID {
	AIRDODGE,
	JUMPBOOST
	
}


var current_item


func item_ID(next_item):
	current_item = next_item
	match current_item:
		item_ID.AIRDODGE:
			StatsManager.abilities.air_dodge = true
		item_ID.JUMPBOOST:
			StatsManager.JUMP_FORCE = -10
			
