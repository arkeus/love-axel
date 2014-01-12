export class GridCollider extends Collider
	new: (@width, @height, @columns = 10, @rows = 10) =>
		error("Grid width and height cannot be 0") if @width == 0 or @height == 0
		super!
		
		@cell_width = math.floor @width / @columns
		@cell_height = math.floor @height / @rows

		@reset!

	reset: =>
		@source_list = {}
		@grid = {}
		@grid[i] = {} for i = 0, @columns * @rows - 1

	build: (source, target) =>
		error("Cannot use spacial hashing on tilemaps") if source.__type == "tilemap" or target.__type == "tilemap"
		@add_all source, @source_list
		@add_to_bucket target

	add_to_bucket: (entity) =>
		if entity.__type == "group"
			@add_to_bucket object for object in *entity.members when object.active and object.exists
		else	
			for x = math.max(0, math.floor(entity.x / @cell_width)), math.min(@columns - 1, math.floor((entity.x + entity.width) / @cell_width))
				for y = math.max(0, math.floor(entity.y / @cell_height)), math.min(@rows - 1, math.floor((entity.y + entity.height) / @cell_height))
					table.insert @grid[y * @columns + x], entity

	overlap: => @overlap_with_callback @\overlap_against_bucket
	collide: => @overlap_with_callback @\collide_against_bucket

	overlap_with_callback: (overlap_function) =>
		overlap_found = false
		for entity in *@source_list
			for x = math.max(0, math.floor(entity.x / @cell_width)), math.min(@columns - 1, math.floor((entity.x + entity.width) / @cell_width))
				for y = math.max(0, math.floor(entity.y / @cell_height)), math.min(@rows - 1, math.floor((entity.y + entity.height) / @cell_height))
					overlap_found = true if overlap_function entity, @grid[y * @columns + x]