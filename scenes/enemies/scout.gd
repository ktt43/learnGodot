extends CharacterBody2D

signal laser(pos,direction)
var player_nearby: bool = false
var can_laser: bool = true
var alternateMarker: bool = true
var health: int = 100

func _ready():
	$AttackArea.body_entered.connect(_on_attack_area_entered)
	$AttackArea.body_exited.connect(_on_attack_area_exited)
	$LaserCooldown.timeout.connect(_on_laser_cooldown_timeout)
	# $DamageCooldown.timeout.connect(_on_damage_cooldown_timeout)

func _process(_delta):
	if(player_nearby):
		look_at(Globals.player_pos)
		if(can_laser):
			var getSelectedMarker = $LaserSpawnPositions.get_child(alternateMarker)
			var pos: Vector2 = getSelectedMarker.global_position
			alternateMarker = !alternateMarker
			var direction: Vector2  = (Globals.player_pos - position).normalized()
			can_laser = false
			laser.emit(pos, direction)
			$LaserCooldown.start()

func _on_attack_area_entered(_body: Node2D) -> void:
	player_nearby = true
	
func _on_attack_area_exited(_body: Node2D) -> void:
	player_nearby = false	 

func _on_laser_cooldown_timeout() -> void:
	can_laser = !can_laser

func hit():
	$DamageCooldown.start()
	health -= 20
	print("Enemy hit, health: ", health)
	if health <= 0:
		queue_free()	
