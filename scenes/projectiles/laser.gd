extends Area2D


@export var speed: int = 1000
var direction: Vector2

func _ready() -> void:
	$Timer.start()

func _process(delta: float) -> void:
	position += direction * speed * delta
		
func _on_timer_timeout():
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if "hit" in body:
		body.hit()
		print(body);
	queue_free()


#func _on_laser_time_timeout() -> void:
	#print("laser Timed Out")
	#queue_free()
