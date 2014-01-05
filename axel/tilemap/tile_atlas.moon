-- Todo: Perhaps quad_set and tile_atlas can be combined
export class TileAtlas
	new: (image, @tile_width, @tile_height) =>
		@image_width = @image\getWidth!
		@image_height = @image\getHeight!

		@columns = math.floor @image_width / @tile_width
		@rows = math.floor @image_height / @tile_height

		@quads = {}
		for y = 0, @rows - 1
			for x = 0, @columns - 1
				@quads[y * @columns + x] = love.graphics.newQuad x * @tile_width, y * @tile_height, @tile_width, @tile_height, @image_width, @image_height

	quad: (index) => @quads[index]