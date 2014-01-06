export class Tilemap extends Entity
	new: (x = 0, y = 0) =>
		super x, y

	load: (data, tileset, tile_width, tile_height) =>
		assert tile_width > 0 and tile_height > 0, "Invalid tile size"

		@width, @height, @columns, @rows, @num_tiles = @get_data_size data, tile_width, tile_height
		@tileset = love.graphics.newImage tileset
		@atlas = QuadSet tile_width, tile_height, @tileset\getWidth!, @tileset\getHeight!
		@batch = love.graphics.newSpriteBatch @tileset, @num_tiles
		@batch\bind!
		for y = 1, #data
			row = data[y]
			for x = 1, #row
				tile = row[x]
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
		love.graphics.push!
		love.graphics.translate @x, @y
		love.graphics.draw @batch
		love.graphics.pop!