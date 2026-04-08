extends PathFollow2D

var player_near: bool = false
@onready var line1: Line2D = $Turret/RayCast2D/Line2D
@onready var line2: Line2D = $Turret/RayCast2D2/Line2D
@onready var gun_fire1: Sprite2D= $Turret/GunFire1;
@onready var gun_fire2: Sprite2D= $Turret/GunFire2;


func fire():
	Globals.health -= 30
	gun_fire1.modulate.a = 1
	gun_fire2.modulate.a = 1

	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(gun_fire1,"modulate:a",0,randf_range(.1,.7))
	tween.tween_property(gun_fire2,"modulate:a",0,randf_range(.1,.7))


func _ready() -> void:
	$NoticeArea.body_entered.connect(onNoticeBodyEntered)
	$NoticeArea.body_exited.connect(onNoticeBodyExited)
	

func _process(delta):
	progress_ratio += .05 * delta
	if(player_near):
		$Turret.look_at(Globals.player_pos)
	# print($Turret/RayCast2D.get_collider())

func onNoticeBodyEntered(_body):
	player_near = true
	$AnimationPlayer.play("laser_load")
	
func onNoticeBodyExited(_body):
	player_near = false
	$AnimationPlayer.stop()
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(line1, "width", 0 , randf_range(.1,.7))
	tween.tween_property(line2, "width", 0 , randf_range(.1,.7))
	await tween.finished
	# $AnimationPlayer.stop()
