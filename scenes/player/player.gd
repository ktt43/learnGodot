extends CharacterBody2D

signal laserShot(pos,direction)
signal grenadeThrown(pos, direction)
signal updateStats

var can_laser: bool = true
var can_grenade: bool = true


@export var max_speed: int = 500
var speed: int = max_speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	#movement
	var direction = Input.get_vector("left","right","up","down")
	velocity = direction * speed
	move_and_slide()
	
	#rotate
	look_at(get_global_mouse_position())
	
# Emit Signal and Position when Player Interacts in Level 
	if(Input.is_action_just_pressed("primary action") and can_laser and Globals.laser_amount>0):
		#print("SHOT")
		Globals.laser_amount -=1;
		$LaserStartPositions/GPUParticles2D.emitting = true
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		var player_direction = (get_global_mouse_position()-position).normalized()
		laserShot.emit(selected_laser.global_position, player_direction)
		can_laser = !can_laser
		$Timer.start()
		
	if(Input.is_action_just_pressed("secondary action") and can_grenade and Globals.grenade_amount>0):
		Globals.grenade_amount -= 1
		var grenade_marker = $GrenadeStartPosition/Marker2D.global_position
		var pos = $GrenadeStartPosition.get_children()[0].global_position
		var player_direction = (get_global_mouse_position() - pos).normalized()
		grenadeThrown.emit(grenade_marker,player_direction)
		can_grenade = !can_grenade
		$grenadeTimer.start()
		
func _on_timer_timeout() -> void:
	can_laser = !can_laser

func _on_grenade_timer_timeout() -> void:
	can_grenade = !can_grenade

func add_item(type: String) -> void:
	if(type == 'laser'):
		Globals.laser_amount+=10
		updateStats.emit()
