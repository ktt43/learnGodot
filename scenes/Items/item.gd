extends Area2D

var rotation_speed: int = 4
var available_options = ['laser','grenade', 'health']
var type = available_options[randi()%len(available_options)]

func _ready() -> void:
	print(type)
	if type == 'laser':
		$Sprite2D.modulate= Color('blue')
	if type == 'grenade':
		$Sprite2D.modulate=Color('green')	
		
func _process(delta: float) -> void:
	rotation += rotation_speed * delta


func _on_body_entered(body: Node2D) -> void:
	body.add_item(type)
	queue_free()
