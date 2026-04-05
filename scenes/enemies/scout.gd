extends CharacterBody2D

signal laser(pos,direction)
var player_nearby: bool = false
var can_laser: bool = true
var alternateMarker: bool = true
var health: int = 100
var damage_cooldown: bool = true

func _ready():
	$AttackArea.body_entered.connect(_on_attack_area_entered)
	$AttackArea.body_exited.connect(_on_attack_area_exited)
	$Node/LaserCooldown.timeout.connect(_on_laser_cooldown_timeout)
	$Node/DamageCooldown.timeout.connect(_on_damage_cooldown_timeout)


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
			$Node/LaserCooldown.start()

func _on_attack_area_entered(_body: Node2D) -> void:
	player_nearby = true
	
func _on_attack_area_exited(_body: Node2D) -> void:
	player_nearby = false	 

func _on_laser_cooldown_timeout() -> void:
	can_laser = !can_laser

func hit():
	
	print("Enemy hit, health: ", health, " damage cooldown: ", damage_cooldown)
	if damage_cooldown:
		$Node/DamageCooldown.start()
		$Sprite2D.material.set_shader_parameter("progress", 1)
		health -= 25
		if health <= 0:
			queue_free()	
		damage_cooldown = false
	
	

func _on_damage_cooldown_timeout() -> void:
	$Sprite2D.material.set_shader_parameter("progress", 0)
	damage_cooldown = true
