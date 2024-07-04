@tool
extends MultiMeshInstance2D

@export var populate_button:bool:
	set(val):
		populate_basic()

var positions:Array[Vector2]
var tile_size:Vector2 = Vector2(32,32)

func populate_basic() -> void:
	tile_size = Vector2(32,32)
	positions.clear()
	for i in 10:
		for j in 10:
			positions.append(Vector2(i,j) * tile_size)
	
	multimesh.instance_count = positions.size()
	
	for i in multimesh.instance_count:
		var grass_bunch_transform:Transform2D
		grass_bunch_transform = grass_bunch_transform \
			.translated(
				(Vector2(positions[i]) + Vector2(.5,.5)) *
				tile_size.x
			)\
			.rotated_local(PI)\
			.scaled_local(tile_size)
		print(grass_bunch_transform)
		multimesh.set_instance_transform_2d(i, grass_bunch_transform)

