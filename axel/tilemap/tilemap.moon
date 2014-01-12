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
		@tileset = @generate_padded_tileset tileset
		@atlas = QuadSet tile_width, tile_height, @tileset\getWidth!, @tileset\getHeight!, 1
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

	generate_padded_tileset: (tileset) =>
		source = love.image.newImageData tileset
		columns = math.floor source\getWidth! / @tile_width
		rows = math.floor source\getHeight! / @tile_height
		target = love.image.newImageData columns * (@tile_width + 2), rows * (@tile_height + 2)
		for y = 1, rows
			for x = 1, columns
				@copy_padded_tile source, target, x - 1, y - 1, @tile_width, @tile_height
		love.graphics.newImage target

	copy_padded_tile: (source, target, x, y, w, h) =>
		w2, h2, x1, y1 = w + 2, h + 2, x + 1, y + 1
		xw2, x1w2, yh2, y1h2 = x * w2, x1 * w2, y * h2, y1 * h2
		target\paste source, xw2 + 1, yh2 + 1, x * w, y * h, w, h
		target\paste source, xw2, yh2 + 1, x * w, y * h, 1, h
		target\paste source, x1w2 - 1, yh2 + 1, x1 * w - 1, y * h, 1, h
		target\paste source, xw2 + 1, yh2, x * w, y * h, w, 1
		target\paste source, xw2 + 1, y1h2 - 1, x * w, y1 * h - 1, w, 1
		target\setPixel xw2, yh2, source\getPixel x * w, y * h
		target\setPixel x1w2 - 1, yh2, source\getPixel x1 * w - 1, y * h
		target\setPixel xw2, y1h2 - 1, source\getPixel x * w, y1 * h - 1
		target\setPixel x1w2 - 1, y1h2 - 1, source\getPixel x1 * w - 1, y1 * h - 1