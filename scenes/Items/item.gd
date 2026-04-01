extends Area2D

var rotation_speed: int = 4
var available_options = ['laser','grenade', 'health']
var type = available_options[randi()%len(available_options)]

var direction: Vector2
var distance: int = randi_range(150,250)

func _ready() -> void:
	#print("spawned")
	#self.body_entered.connect(_on_body_entered)
	
	print(type)
	if type == 'laser':
		$Sprite2D.modulate= Color('blue')
	if type == 'grenade':
		$Sprite2D.modulate=Color('green')	
	if type == 'health':
		$Sprite2D.modulate=Color('white')	
		
	var target_pos = position + direction * distance	
	var movement_tween = create_tween()
	movement_tween.tween_property(self,"position", target_pos, 0.5)
	
func _process(delta: float) -> void:
	rotation += rotation_speed * delta


func _on_body_entered(body: Node2D) -> void:
	print(body, " entered")
	if(type == 'laser'):
		Globals.laser_amount +=10
	if(type == 'grenade'):
		Globals.grenade_amount +=3
	if type == 'health':
		Globals.health +=10
	queue_free()
