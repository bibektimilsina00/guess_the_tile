extends Node


const  GROUP_TILE='tile'

const LEVELS:Dictionary={
	1:{"rows":2,"cols":2},
	2:{"rows":3,"cols":4},
	3:{"rows":4,"cols":4},
	4:{"rows":4,"cols":6},
	5:{"rows":5,"cols":6},
	6:{"rows":6,"cols":6},
}



func get_level_selection(level_num:int)-> Dictionary:
	var ldata=GameManager.LEVELS[level_num]
	var num_of_tiles = ldata.rows * ldata.cols
	var target_pairs:int = num_of_tiles / 2 
	var selected_level_image=[]
	ImageManager.suffle_images()
	for i in range(target_pairs):
		selected_level_image.append(ImageManager.get_image(i))
		selected_level_image.append(ImageManager.get_image(i))
	selected_level_image.shuffle()
	return{
		'target_pairs':target_pairs,
		'no_cols':ldata.cols,
		'image_list':selected_level_image
	}
	
	
func clear_node_of_group(g_name:String)->void:
	for n in get_tree().get_nodes_in_group(g_name):
		n.queue_free()
	
	
	
	
	
