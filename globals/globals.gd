extends Node

signal stat_change
var player_pos: Vector2

var player_hit_sound = AudioStreamPlayer2D


func _ready():
	player_hit_sound = AudioStreamPlayer2D.new()
	player_hit_sound.stream = load('res://audio/solid_impact.ogg')
	add_child(player_hit_sound)
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
		
var player_vulnerable: bool = true		
var health = 20:
	get:
		#print(health)
		return health
	set(value):
		if player_vulnerable:
			health = value
			player_vulnerable = false
			player_vulnerable_timer()
			player_hit_sound.play()
		#Player can always pick up health, even if they are invulnerable. Max Health is 100
		elif value > health:
			health = min(value, 100)
		
		stat_change.emit()


func player_vulnerable_timer():
	await get_tree().create_timer(0.5).timeout
	player_vulnerable = true
