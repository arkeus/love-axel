export class Tilemap extends Entity
	new: (x = 0, y = 0) =>
		super x, y

	load: (data, tileset, tile_width, tile_height) =>
		assert tile_width > 0 and tile_height > 0, "Invalid tile size"

		@tileset = love.graphics.newImage tileset
		@atlas = QuadSet tile_width, tile_height, @tileset\getWidth!, @tileset\getHeight!
		@batch = love.graphics.newSpriteBatch @tileset
		@batch\bind!
		for y = 1, #data
			row = data[y]
			for x = 1, #row
				tile = row[x]
				continue if tile < 1
				@batch\add @atlas\get(tile - 1), (x - 1) * tile_width, (y - 1) * tile_height
		@batch\unbind!

	draw: =>
		love.graphics.push!
		love.graphics.translate @x, @y
		love.graphics.draw @batch
		love.graphics.pop!