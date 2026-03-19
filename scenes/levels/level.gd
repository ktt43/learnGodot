extends Node2D

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:	
	pass

func _on_gate_player_entered_gate(body) -> void:
	print("Called from Level")
	print(body)

# Listens for Event from Player and Create the instance at the Position that is emitted, then add it to the Level
func _on_player_laser_shot(pos, direction) -> void:
	var laser = laser_scene.instantiate() as Area2D
	
	laser.position = pos
	laser.rotation_degrees = rad_to_deg(direction.angle())+90
	laser.direction = direction
	$Projectiles.add_child(laser)
	
func _on_player_grenade_thrown(pos, direction) -> void:
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.speed
	$Projectiles.add_child(grenade)
	
