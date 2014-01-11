export class Tilemap extends Entity
	__type: "tilemap"

	new: (x = 0, y = 0) =>
		super x, y
		@frame = Rectangle!

	load: (data, tileset, tile_width, tile_height, solid_index = 1) =>
		assert tile_width > 0 and tile_height > 0, "Invalid tile size"

		@width, @height, @columns, @rows, @num_tiles = @get_data_size data, tile_width, tile_height
		@tile_width, @tile_height = tile_width, tile_height
		@data = {}
		@tileset = love.graphics.newImage tileset
		@atlas = QuadSet tile_width, tile_height, @tileset\getWidth!, @tileset\getHeight!
		@batch = love.graphics.newSpriteBatch @tileset, @num_tiles

		@tiles = {}
		for t = 1, @num_tiles
			table.insert @tiles, Tile self, t, t >= solid_index

		@batch\bind!
		for y = 1, #data
			row = data[y]
			for x = 1, #row
				tile = row[x]
				@data[(y - 1) * @columns + (x - 1)] = tile
				continue if tile < 1
				@batch\add @atlas\get(tile - 1), (x - 1) * tile_width, (y - 1) * tile_height
		@batch\unbind!

	get_data_size: (data, tile_width, tile_height) =>
		width, height, rows, columns, num_tiles = 0, 0, 0, 0, 0
		rows = #data
		for y = 1, #data
			row = data[y]
			columns = math.max columns, #row
			num_tiles += #row
		columns * tile_width, rows * tile_height, columns, rows, num_tiles		

	draw: =>
		axel.debugger.draws += 1
		love.graphics.draw @batch

	overlap: (target, callback = nil, collide = false) =>
		tdx = target.x - target.previous.x
		tdy = target.y - target.previous.y

		@frame.x = if target.x < target.previous.x then target.x else target.previous.x
		@frame.y = if target.y < target.previous.y then target.y else target.previous.y
		@frame.width = math.abs(tdx) + target.width
		@frame.height = math.abs(tdy) + target.height

		sx = math.floor (@frame.x - @x) / @tile_width
		sy = math.floor (@frame.y - @y) / @tile_height
		ex = math.floor (@frame.x + @frame.width - @x - epsilon) / @tile_width
		ey = math.floor (@frame.y + @frame.height - @y - epsilon) / @tile_height

		sx = 0 if sx < 0
		sy = 0 if sy < 0
		ex = @columns - 1 if ex > @columns - 1
		ey = @rows - 1 if ex > @rows - 1

		overlapped = false
		tile = Entity 0, 0, @tile_width, @tile_height
		for x = sx, ex
			for y = sy, ey
				tid = @data[y * @columns + x]
				continue if tid == 0
				tile_object = @tiles[tid]
				tile_object.callback tile_object, target if tile_object.callback
				continue unless tile_object.solid
				tile.x = x * @tile_width + @x
				tile.y = y * @tile_height + @y
				tile.previous.x = tile.x
				tile.previous.y = tile.y
				overlapped = callback target, tile
		overlapped

	get_tile: (id) => @tiles[id]
	get_tiles: (ids) => [@tiles[id] for id in *ids]