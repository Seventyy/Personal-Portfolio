extends MultiMeshInstance2D

@onready var foliage: Foliage = owner
@onready var tilemap:TileMap = foliage.tilemap
@onready var positions:Array[Vector2i] = tilemap.get_used_cells(0)
@onready var tile_size:Vector2 = tilemap.tile_set.tile_size 

@export var hight_noise:Noise
@export var width_noise:Noise
@export var position_noise:Noise

func _ready() -> void:
	#populate_basic()
	#populate_double()
	populate_with_hight_variation()
	
func populate_with_hight_variation():
	multimesh.instance_count = positions.size()
	
	for i in positions.size():
		
		var grass_position = \
			(Vector2(positions[i]) + Vector2(.5,.5)) * \
			tile_size.x
		var grass_scale:Vector2 = \
			tile_size * remap(
			hight_noise.get_noise_2dv(
			Vector2(positions[i]) * tile_size),
			-1, 1, .5, 1.5)
		
		var grass_bunch_transform:Transform2D
		grass_bunch_transform = grass_bunch_transform \
			.translated(Vector2(0,-.5))\
			.scaled(grass_scale)\
			.translated(Vector2(0,.5 * tile_size.y))\
			.translated(grass_position)\
			.rotated_local(PI)
		
		multimesh.set_instance_transform_2d(i, grass_bunch_transform)

func populate_double() -> void:
	multimesh.instance_count = positions.size() * 2
	
	for i in positions.size():
		for j in 2:
			var grass_bunch_transform:Transform2D
			grass_bunch_transform = grass_bunch_transform \
				.translated(
					(Vector2(positions[i]) + Vector2(.5, float(j)/2)) *
					tile_size.x
				)\
				.rotated_local(PI)\
				.scaled_local(tile_size)
			multimesh.set_instance_transform_2d(i*2+j, grass_bunch_transform)

func populate_basic() -> void:
	multimesh.instance_count = positions.size()
	
	for i in positions.size():
		var grass_bunch_transform:Transform2D
		grass_bunch_transform = grass_bunch_transform \
			.translated(
				(Vector2(positions[i]) + Vector2(.5,.5)) *
				tile_size.x
			)\
			.rotated_local(PI)\
			.scaled_local(tile_size)
		multimesh.set_instance_transform_2d(i, grass_bunch_transform)
