extends Area2D

var rotation_speed: int = 4
var available_options = ['laser','grenade', 'health']
var type = available_options[randi()%len(available_options)]



func _ready() -> void:
	self.body_entered.connect(_on_body_entered)
	
	print(type)
	if type == 'laser':
		$Sprite2D.modulate= Color('blue')
	if type == 'grenade':
		$Sprite2D.modulate=Color('green')	
	if type == 'health':
		$Sprite2D.modulate=Color('white')	
		
func _process(delta: float) -> void:
	rotation += rotation_speed * delta


func _on_body_entered(_body: Node2D) -> void:
	if(type == 'laser'):
		Globals.laser_amount +=10
	if(type == 'grenade'):
		Globals.grenade_amount +=3
	if type == 'health':
		Globals.health +=10
	queue_free()
