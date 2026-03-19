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

func _on_player_laser_shot(pos) -> void:
	var laser = laser_scene.instantiate()
	laser.position= pos
	$Projectiles.add_child(laser)
	
func _on_player_grenade_thrown(pos) -> void:
	var grenade = grenade_scene.instantiate()
	grenade.position = pos
	$Projectiles.add_child(grenade)
	
