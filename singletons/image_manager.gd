extends Node


const  _frame_images:Array=[
	preload("res://assets/frames/blue_frame.png"),
	preload("res://assets/frames/green_frame.png"),
	preload("res://assets/frames/red_frame.png"),
	preload("res://assets/frames/yellow_frame.png"),
]

var _item_images:Array=[]

 
func _ready():
	load_item_images()
	
	
func add_file_to_list(fn:String,path:String):
	var full_path:String=path+'/'+fn
	var ii_dict:Dictionary={
		"item_name":fn.rstrip('.png'),
		'item_texture':load(full_path)
	}
	_item_images.append(ii_dict)


 

func load_item_images():
	var path="res://assets/glitch/"
	var dir= DirAccess.open(path)
	if not dir:
		print("Error",path)
		return
	
	var files=dir.get_files()
	for fn in files:
		if "import" not in fn:
			add_file_to_list(fn,path)
	


func get_random_image()-> Dictionary:
	return _item_images.pick_random()
	
	
func get_image(index:int)-> Dictionary:
	return _item_images[index]
	
	
func get_random_frame_image()->CompressedTexture2D:
	return _frame_images.pick_random()
	
	
func suffle_images()-> void:
	_item_images.shuffle()
