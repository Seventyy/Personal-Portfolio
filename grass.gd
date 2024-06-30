extends MultiMeshInstance2D

@onready var foliage: Foliage = owner

func _ready() -> void:
	var tilemap:TileMap = foliage.tilemap
	var positions:Array[Vector2i] = tilemap.get_used_cells(0)
	
	multimesh.instance_count = positions.size()
	
	for i in positions.size():
		var grass_bunch_transform:Transform2D
		grass_bunch_transform = grass_bunch_transform.translated(
			positions[i] * tilemap.tile_set.tile_size.x
		)
		multimesh.set_instance_transform_2d(i, grass_bunch_transform)
		
#for i in multimesh.instance_count:
		#var transform2D = Transform2D()
		#transform2D = transform2D.translated(Vector2(
			#rng.randf_range(-box_size/2,box_size/2),
			#(float(i)/multimesh.instance_count-.5) * box_size
		#))
		#multimesh.set_instance_transform_2d(i, transform2D)
