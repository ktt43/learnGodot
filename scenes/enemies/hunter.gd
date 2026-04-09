extends CharacterBody2D

var active: bool = false
var speed: int = 400
var vulnerable: bool = true
var health: int = 80   


func _ready() -> void:
	$NoticeArea.body_entered.connect(onNoticeBodyEntered)
	$NoticeArea.body_exited.connect(onNoticeBodyExited)
	$AttackArea.body_entered.connect(onAttackBodyEntered)
	#$HitTimer.timeout.connect(onTimerTimeout)
	#$Sprite2D.material = $Sprite2D.material.duplicate()

	$Timers/NavigationTimer.timeout.connect(_onNavigationTimerTimeout)

#Explain calldefered, physics_process

func process(_delta):
	pass

func _physics_process(_delta):
	if(active):
		var next_path_pos: Vector2 = $NavigationAgent2D.get_next_path_position()
		var direction: Vector2 = (next_path_pos - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
		look_at(Globals.player_pos)
   



func onNoticeBodyEntered(_body):
	active = true

func onNoticeBodyExited(_body):
	active = false

func onAttackBodyEntered(_body):
	pass


func _onNavigationTimerTimeout():
	if(active):
		$NavigationAgent2D.target_position = Globals.player_pos
		print($NavigationAgent2D.target_position)
