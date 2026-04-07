extends CharacterBody2D

var isAttackOnCooldown = false 
var inNoticeArea = false
var inAttackArea = false
var speed = 300
var vulnerable: bool = true

func _ready():
	$AttackCooldown.timeout.connect(_onAttackTimerTimeout)
	$NoticeArea2D.body_entered.connect(_onNoticeAreaBodyEntered)
	$NoticeArea2D.body_exited.connect(_onNoticeAreaBodyExited)
	$AttackArea2D.body_entered.connect(_onAttackAreaBodyEntered)
	$AttackArea2D.body_exited.connect(_onAttackAreaBodyExited)

func _process(_delta: float) -> void:
	if(inNoticeArea):
		look_at(Globals.player_pos)
		move();
		if(inAttackArea):
			attack()

func move() -> void:
	print("moving")
	var direction = (Globals.player_pos - position).normalized()
	velocity = direction * speed
	move_and_slide()

func attack():
	print("attacking")
	$AttackCooldown.start()
	if(inAttackArea and !isAttackOnCooldown):
		$AnimatedSprite2D.animation = "Attack"
		isAttackOnCooldown = true
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
	
