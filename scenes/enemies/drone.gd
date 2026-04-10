extends CharacterBody2D

var active: bool = false
var speed: int = 400
var vulnerable: bool = true
var health: int = 40
var inBlastRadius: bool = false
var speedMultiplier: int = 1

func _ready() -> void:
	$NoticeArea.body_entered.connect(onNoticeBodyEntered)
	$HitTimer.timeout.connect(onTimerTimeout)
	$Explosion.hide()
	$Sprite2D.material = $Sprite2D.material.duplicate()
	$BlastRadius.body_entered.connect(_onBlastRadiusBodyEntered)
	
func _process(delta):
	if(active):
		look_at(Globals.player_pos)
		var direction = (Globals.player_pos - global_position).normalized()
		velocity = direction * speed * speedMultiplier
		if move_and_collide(velocity * delta):
			explode()


func hit():
	
	if(vulnerable):
		$Node/HitSound.play()
		
		print($Node/HitSound.playing)
		vulnerable = false
		$HitTimer.start()
		health -= 10
		$Sprite2D.material.set_shader_parameter("progress",.5)
		
		if(health <= 0):
			explode()
	
func stopMovement():
	speedMultiplier = 0


func onNoticeBodyEntered(_body):
	Callable(create_tween(),"tween_property").call(self,"speed",500,1)
	#Alternatively:
	# var tween = create_tween()
	# tween.tween_property(self,"speed",690,1)
	active = true

func onTimerTimeout():
	vulnerable = true
	$Sprite2D.material.set_shader_parameter("progress",0)

func _onBlastRadiusBodyEntered(body):
	print(body)

func explode():
	#var blast_radius = $BlastRadius.get_overlapping_bodies()
	# print(blast_radius)
	var targets = get_tree().get_nodes_in_group("Entity") + get_tree().get_nodes_in_group("Container")
	$AnimationPlayer.play("Explosion")
	for body in targets:
		var in_range = body.global_position.distance_to(global_position) <=  $BlastRadius/CollisionShape2D.shape.radius
		if in_range and "hit" in body:
			body.hit()
