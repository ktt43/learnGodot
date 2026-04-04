extends Node

signal stat_change
var player_pos: Vector2


var laser_amount = 20:
	get:
		#print(laser_amount)
		return laser_amount
		
	set(value):
		laser_amount=value
		stat_change.emit()
		#print("new Laser", laser_amount)
		
var grenade_amount = 3:
	get:
		#print(grenade_amount)
		return grenade_amount
		
	set(value):
		grenade_amount=value
		stat_change.emit()
		
var health = 20:
	get:
		#print(health)
		return health
	set(value):
		health = value
		stat_change.emit()
