extends StaticBody2D
class_name genericObject

@onready var current_direction: Vector2 = Vector2.DOWN.rotated(rotation)

signal open(pos,direction)
var opened: bool = false
var genericObject_hit_sound: AudioStreamPlayer2D

func _ready():
	genericObject_hit_sound = AudioStreamPlayer2D.new()
	genericObject_hit_sound.stream = load('res://audio/container_hit.mp3')
	add_child(genericObject_hit_sound)


