extends CharacterBody2D

var isAttackOnCooldown = false 
var inNoticeArea = false
var inAttackArea = false
var speed = 300
var vulnerable: bool = true
var health = 100
var player_hit_sound: AudioStreamPlayer2D
# var bugHitSound: AudioStreamPlayer2D

func _ready():
	$AttackCooldown.timeout.connect(_onAttackTimerTimeout)
	$NoticeArea2D.body_entered.connect(_onNoticeAreaBodyEntered)
	$NoticeArea2D.body_exited.connect(_onNoticeAreaBodyExited)
	$AttackArea2D.body_entered.connect(_onAttackAreaBodyEntered)
	$AttackArea2D.body_exited.connect(_onAttackAreaBodyExited)
	$AnimatedSprite2D.animation_finished.connect(_onAnimationFinished)
	$HitCooldown.timeout.connect(_onHitCooldownTimeout)
	$AnimatedSprite2D.material = $AnimatedSprite2D.material.duplicate()

	# bugHitSound = AudioStreamPlayer2D.new()
	# bugHitSound.stream = load('res://audio/bug_hit.ogg')
	# add_child(bugHitSound)


func _process(_delta: float) -> void:
	if(inAttackArea):
		attack()
	elif (inNoticeArea):
		look_at(Globals.player_pos)
		move();
	

func move() -> void:
	# print("moving")
	var direction = (Globals.player_pos - position).normalized()
	velocity = direction * speed
	$AnimatedSprite2D.play("Walk")
	move_and_slide()

func attack():
	if(!isAttackOnCooldown):
		print("Attacking")
		$AttackCooldown.start()
		$AnimatedSprite2D.play("Attack")
		#should call onAnimationFinished here
		isAttackOnCooldown = true
		
	
func hit():
	if(vulnerable):
		print("Hit")
		$AnimatedSprite2D.material.set_shader_parameter("progress", .5)
		$Particles/HitParticles.emitting = true
		vulnerable = false
		$HitCooldown.start()
		$AudioStreamPlayer2D.play()
		health -= 25
		if(health <= 0):
			await get_tree().create_timer(0.5).timeout
			queue_free(	)

func _onAnimationFinished():
	print("Animation finished")
	if(inAttackArea):
		print(inAttackArea)
		Globals.health -= 10

func _onNoticeAreaBodyEntered(_body):
	print("Player entered notice area")
	inNoticeArea = true

func _onNoticeAreaBodyExited(_body):
	print("Player exited notice area")
	inNoticeArea = false

func _onAttackAreaBodyEntered(_body):
	print("Player entered attack area")
	inAttackArea = true

func _onAttackAreaBodyExited(_body):
	print("Player exited attack area")
	inAttackArea = false

func _onAttackTimerTimeout():
	isAttackOnCooldown = false
	
func _onHitCooldownTimeout():
	vulnerable = true
	$AnimatedSprite2D.material.set_shader_parameter("progress", 0)

