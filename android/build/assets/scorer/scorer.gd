extends Node

class_name  Scorer

@onready var sound = $Sound
@onready var reveal_timer = $RevealTimer





var _tiles:Array=[]
var _selections:Array=[]
var _target_pairs:int=0
var _move_made:int=0
var _match_made:int=0



func get_move_made()-> String:
	return str(_move_made)
	
func get_match_made()->String:
	return "%s / %s" %[_match_made/2,_target_pairs]


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_tile_selected.connect(on_tile_selected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func update_selection():
	reveal_timer.start()
	if selection_are_pair():
		kill_tiles()
		
func kill_tiles():
	for s in _selections:
		s.kill_on_success()
		_match_made+=1
		SoundManager.play_sound(sound,SoundManager.SOUND_SUCCESS)
	
 	
	
func clear_new_game(target_pairs:int)->void:
	_selections.clear()
	_match_made=0
	_move_made=0
	_target_pairs=target_pairs
	_tiles=get_tree().get_nodes_in_group(GameManager.GROUP_TILE)
	
	
func selection_are_pair()->bool:
	print(_selections[0].get_item_name()==_selections[1].get_item_name()
	and  _selections[0].get_instance_id()!=_selections[1].get_instance_id())
	return (_selections[0].get_item_name()==_selections[1].get_item_name()
	and  _selections[0].get_instance_id()!=_selections[1].get_instance_id()
	)
	
	
	
func check_match_made(tile:MemoryTile)->void:
	tile.reveal(true)
	_selections.append(tile)
	if _selections.size() != 2 :
		return
	SignalManager.on_selection_disabled.emit()
	_move_made+=1
	update_selection()
		
	

func on_tile_selected(tile:MemoryTile)->void:
	SoundManager.play_tile_click(sound)
	check_match_made(tile)


func _on_reveal_timer_timeout():
	if selection_are_pair() == false:
		hide_selections()
	_selections.clear()
	check_game_over()
	SignalManager.on_selection_enabled.emit()
	
	
func hide_selections():
	for s in _selections:
		s.reveal(false)
		
func check_game_over():
	if _match_made/2>=_target_pairs:
		SignalManager.on_game_over.emit(_move_made)
