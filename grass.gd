extends MultiMeshInstance2D

@onready var foliage: Foliage = owner

func _ready() -> void:
	var tilemap:TileMap = foliage.tilemap
	var positions:Array[Vector2i] = tilemap.get_used_cells(0)
	
	multimesh.instance_count = positions.size()
	
	for i in positions.size():
		var grass_bunch_transform:Transform2D
		grass_bunch_transform = grass_bunch_transform \
			.translated(
				(Vector2(positions[i]) + Vector2(.5,.5)) *
				tilemap.tile_set.tile_size.x
			)\
			.rotated_local(PI)\
			.scaled_local(tilemap.tile_set.tile_size)
		multimesh.set_instance_transform_2d(i, grass_bunch_transform)
