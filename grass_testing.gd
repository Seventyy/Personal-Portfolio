@tool
extends MultiMeshInstance2D

@export var populate_button:bool:
	set(val):
		populate_basic()
@export var box_size:Vector2i
@export var tile_size:Vector2 = Vector2(32,32)

var positions:Array[Vector2i]

func populate_basic() -> void:
	positions.clear()
	for x in box_size.x:
		for y in box_size.y:
			positions.append(Vector2i(x,y))
	
	multimesh.instance_count = positions.size()
	
	for i in multimesh.instance_count:
		var grass_bunch_transform:Transform2D
		grass_bunch_transform = grass_bunch_transform \
			.translated(
				(Vector2(positions[i]) + Vector2(.5,.5)) * tile_size.x
			)\
			.rotated_local(PI)\
			.scaled_local(tile_size)
		print(grass_bunch_transform)
		multimesh.set_instance_transform_2d(i, grass_bunch_transform)

