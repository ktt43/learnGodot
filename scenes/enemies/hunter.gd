extends CharacterBody2D

var active: bool = false
var speed: int = 400
var vulnerable: bool = true
var health: int = 80   
var player_in_range: bool = false

func _ready() -> void:
	$NoticeArea.body_entered.connect(onNoticeBodyEntered)
	$NoticeArea.body_exited.connect(onNoticeBodyExited)
	$AttackArea.body_entered.connect(onAttackBodyEntered)
	$AttackArea.body_exited.connect(onAttackBodyExited)
	$Timers/HitTimer.timeout.connect(onTimerTimeout)
	#$Sprite2D.material = $Sprite2D.material.duplicate()
	$NavigationAgent2D.target_position = Globals.player_pos
	$Timers/NavigationTimer.timeout.connect(_onNavigationTimerTimeout)
	$NavigationAgent2D.path_desired_distance = 4.0
	$NavigationAgent2D.target_desired_distance = 4.0
#Explain calldefered, physics_process, direction angle

func process(_delta):
	pass

func _physics_process(_delta):
	if(active):
		var next_path_pos: Vector2 = $NavigationAgent2D.get_next_path_position()
		var direction: Vector2 = (next_path_pos - global_position).normalized()
		velocity = direction * speed
		queue_redraw()
		move_and_slide()
		var look_angle= direction.angle()
		rotation = look_angle + PI / 2
	
	
func attack():
	if(player_in_range):
		Globals.health -= 50

func hit():
	if(vulnerable):
		$AudioStreamPlayer2D.play()
		$GPUParticles2D.emitting = true
		health -= 20
		vulnerable = false
		$Timers/HitTimer.start()
	if(health <= 0):
		queue_free()

func onNoticeBodyEntered(_body):
	active = true
	$AnimationPlayer.play("walk")

func onNoticeBodyExited(_body):
	active = false

func onAttackBodyEntered(_body):
	player_in_range = true
	$AnimationPlayer.play("attack")

func onAttackBodyExited(_body):
	player_in_range = false

func onTimerTimeout():
	vulnerable = true


func _onNavigationTimerTimeout():
	if(active):
		$NavigationAgent2D.target_position = Globals.player_pos
		print($NavigationAgent2D.target_position)
