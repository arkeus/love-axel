export class Entity extends Rectangle
	new: (x = 0, y = 0) =>
		super x, y

		@angle = 0
		@offset = Rectangle!

		@visible = true
		@active = true
		@solid = true
		@exists = true

		@center = Point @x + @width / 2, @y + @height / 2
		@previous = Point @x, @y

		@velocity = Vector!
		@acceleration = Vector!
		@max_velocity = Vector math.huge, math.huge, math.huge
		@drag = Vector!