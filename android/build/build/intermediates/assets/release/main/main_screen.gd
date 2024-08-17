extends Control


@export var level_button:PackedScene
@onready var hb_levels = $VB/HBLevels


func _ready():
	
	setup_grid()
	
func create_level_button(ln:int)-> void:
	var button=level_button.instantiate()
	hb_levels.add_child(button)
	button.set_level_number(ln)
	



func setup_grid()-> void:
	for level in GameManager.LEVELS:
		create_level_button(level)
