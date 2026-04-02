extends CanvasLayer

#colors
var green: Color = Color("6bbfa3")
var red: Color = Color(.9,0,0,1)


@onready var laserLabel: Label = $LaserCounter/VBoxContainer/Label 
@onready var grenadeLabel: Label = $GrenadeCounter/VBoxContainer/Label 
@onready var laserIcon: TextureRect = $LaserCounter/VBoxContainer/TextureRect
@onready var grenadeIcon: TextureRect = $GrenadeCounter/VBoxContainer/TextureRect
@onready var health_bar: TextureProgressBar = $MarginContainer/TextureProgressBar

func _ready() -> void:
	update_stat_text()
	Globals.connect("stat_change", update_stat_text)

	
func update_laser_text():

	laserLabel.text = str(Globals.laser_amount)
	update_color(Globals.laser_amount,laserLabel,laserIcon)
	
func update_grenade_text():
	#print("called update_grenade_text")
	grenadeLabel.text = str(Globals.grenade_amount)
	update_color(Globals.grenade_amount,grenadeLabel,grenadeIcon)

func update_health_text():
	health_bar.value = Globals.health
	
func update_stat_text():
	update_laser_text()
	update_grenade_text()
	update_health_text()
	
func update_color(amount, label: Label,icon: TextureRect) -> void:
	if(amount > 0):
		#label and icon green
		label.modulate = green
		icon.modulate = green
	else:
		#label and icon red
		label.modulate = red
		icon.modulate = red
	
		
