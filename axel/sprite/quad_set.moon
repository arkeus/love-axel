export class QuadSet
	new: (@width, @height, @image_width, @image_height) =>
		@quads = {}
		@columns = math.floor @image_width / @width
		@rows = math.floor @image_height / @height
		for y = 0, @rows - 1
			for x = 0, @columns - 1
				@quads[y * @columns + x] = love.graphics.newQuad x * @width, y * @height, @width, @height, @image_width, @image_height

	get: (index) => @quads[index]