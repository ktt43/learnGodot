extends CharacterBody2D

signal laserShot(pos)
signal grenadeThrown

var can_laser: bool = true
var can_grenade: bool = true
const speed = 400

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var direction = Input.get_vector("left","right","up","down")
	velocity = direction * speed
	move_and_slide()
	
		
	if(Input.is_action_just_pressed("primary action") and can_laser):
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		laserShot.emit(selected_laser.global_position)
		can_laser = !can_laser
		$Timer.start()
		
	if(Input.is_action_just_pressed("secondary action") and can_grenade):
		var grenade_marker = $GrenadeStartPosition/Marker2D.global_position
		grenadeThrown.emit(grenade_marker)
		can_grenade = !can_grenade
		$grenadeTimer.start()
		
func _on_timer_timeout() -> void:
	can_laser = !can_laser

func _on_grenade_timer_timeout() -> void:
	can_grenade = !can_grenade
