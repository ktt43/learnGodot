extends Node2D
class_name LevelParent


var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")
var item_scene: PackedScene = preload("res://scenes/Items/item.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for container in get_tree().get_nodes_in_group("Container"):
		container.connect("open", _on_container_opened)
	for scout in get_tree().get_nodes_in_group("Scouts"):
		scout.connect('laser', _on_scout_laser)
		
func _on_container_opened(pos, direction):
	#print('container opened ', pos, " ", direction)
	var item = item_scene.instantiate()
	item.position = pos
	#$Items.add_child(item)
	item.direction = direction
	$Items.call_deferred('add_child',item)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:	
	pass


	
func create_laser(pos, direction) -> void:
	var laser = laser_scene.instantiate() as Area2D
	laser.position = pos
	laser.rotation_degrees = rad_to_deg(direction.angle())+90
	laser.direction = direction
	$Projectiles.add_child(laser)

# Listens for Event from Player and Create the instance at the Position that is emitted, then add it to the Level
func _on_player_laser_shot(pos, direction) -> void:
	create_laser(pos, direction)
	#$UI.update_laser_text()

func _on_scout_laser(pos, direction) -> void:
	create_laser(pos, direction)


func _on_player_grenade_thrown(pos, direction) -> void:
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.speed
	$Projectiles.add_child(grenade)	
	#$UI.update_grenade_text()





