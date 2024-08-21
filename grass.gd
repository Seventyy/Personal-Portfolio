@tool
extends MultiMeshInstance2D


@export var tilemap:TileMap

@export var hight_noise:Noise
@export var width_noise:Noise
@export var position_noise:Noise

@onready var positions:Array[Vector2i]
@onready var tile_size:Vector2 = tilemap.tile_set.tile_size 

@export var trigger_ready:bool:
	set(val):
		_ready()

@export var spawn_single:bool:
	set(val):
		multimesh.instance_count = 1
		
		var grass_bunch_transform:Transform2D
		grass_bunch_transform = grass_bunch_transform \
			.rotated_local(PI) \
			.scaled_local(Vector2.ONE * 32)
		multimesh.set_instance_transform_2d(0, grass_bunch_transform)



func _ready() -> void:
	positions += tilemap.get_used_cells_by_id(0, -1, Vector2i(1,1))
	#positions += tilemap.get_used_cells_by_id(0, -1, Vector2i(5,1))
	positions += tilemap.get_used_cells_by_id(0, -1, Vector2i(6,1))
	#positions += tilemap.get_used_cells_by_id(0, -1, Vector2i(5,0))
	positions += tilemap.get_used_cells_by_id(0, -1, Vector2i(6,0))
	#populate_test_rectangle()
	populate_basic()
	#populate_double()
	#populate_with_scale_variation()
	#populate_with_scale_variation_and_density_multiplier(5)

func populate():
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

func populate_test_rectangle(size:Vector2i = Vector2i(50, 50)):
	positions.clear()
	
	for x in size.x:
		for y in size.y:
			positions.append(Vector2i(x, y))
	
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

func populate_with_scale_variation_and_density_multiplier(amount_per_tile:int = 1):
	multimesh.instance_count = positions.size()
	
	for i in positions.size():
		for j in amount_per_tile:
			
			var grass_position = \
				(Vector2(positions[i]) +\
				Vector2(.5, float(j) / amount_per_tile)) * \
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
			
			multimesh.set_instance_transform_2d(i * amount_per_tile + j, grass_bunch_transform)

func populate_with_scale_variation():
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
