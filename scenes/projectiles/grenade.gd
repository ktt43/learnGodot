extends RigidBody2D

var direction: Vector2 = Vector2.UP
var speed: int = 200

func _process(delta: float) -> void:
	position += speed * direction * delta
