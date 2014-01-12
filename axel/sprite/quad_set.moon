export class QuadSet
	new: (@width, @height, @image_width, @image_height, @padding = 0) =>
		@quads = {}
		p2 = @padding * 2
		@columns = math.floor @image_width / (@width + p2)
		@rows = math.floor @image_height / (@height + p2)
		for y = 0, @rows - 1
			for x = 0, @columns - 1
				@quads[y * @columns + x] = love.graphics.newQuad x * (@width + p2) + @padding, y * (@height + p2) + @padding, @width, @height, @image_width, @image_height

	get: (index) => @quads[index]