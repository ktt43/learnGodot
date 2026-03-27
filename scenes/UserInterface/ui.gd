extends CanvasLayer

#colors
var green: Color = Color("6bbfa3")
var red: Color = Color(.9,0,0,1)


@onready var laserLabel: Label = $LaserCounter/VBoxContainer/Label 
@onready var grenadeLabel: Label = $GrenadeCounter/VBoxContainer/Label 
@onready var laserIcon: TextureRect = $LaserCounter/VBoxContainer/TextureRect
@onready var grenadeIcon: TextureRect = $GrenadeCounter/VBoxContainer/TextureRect

func _ready() -> void:
	update_laser_text()
	update_grenade_text()
	
func update_laser_text():
	laserLabel.text = str(Globals.laser_amount)
	laserLabel.modulate = green
	laserIcon.modulate = green
	
func update_grenade_text():
	grenadeLabel.text = str(Globals.grenade_amount)
	grenadeLabel.modulate = green
	grenadeIcon.modulate = green
		
