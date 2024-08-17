extends Control

@onready var sound = $Sound
@onready var tile_container = $HB/MC1/TileContainer

@export var mem_tile_scene:PackedScene
@onready var scorer:Scorer = $Scorer
@onready var move_label = $HB/MC2/VBoxContainer/HB/MoveLabel
@onready var match_label = $HB/MC2/VBoxContainer/HB2/MatchLabel
 
# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_level_selected.connect(on_level_selected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_label.text=scorer.get_move_made()
	match_label.text=scorer.get_match_made()


func _on_exit_button_pressed():
	SoundManager.play_button_click(sound)
	SignalManager.on_game_exit_pressed.emit()
	


func on_level_selected(level_num:int)-> void:
	var level_selection=GameManager.get_level_selection(level_num)
	var frame_image=ImageManager.get_random_frame_image()
	tile_container.columns=level_selection.no_cols
	
	for ii_dict in level_selection.image_list:
		add_memory_tile(ii_dict,frame_image)
	scorer.clear_new_game(level_selection.target_pairs)
	
		
	
func add_memory_tile(ii_dict:Dictionary,frame_image:CompressedTexture2D)->void:
	var new_tile= mem_tile_scene.instantiate()
	tile_container.add_child(new_tile)
	new_tile.setup(ii_dict,frame_image)
	
