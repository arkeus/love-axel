export class Entity extends Rectangle
	new: (x = 0, y = 0, width = 0, height = 0) =>
		super x, y, width, height

		@angle = 0
		@offset = Rectangle!

		@visible = true
		@active = true
		@solid = true
		@exists = true

		@center = Point @x + @width / 2, @y + @height / 2
		@previous = Point @x, @y

		@velocity = Vector!
		@pvelocity = Vector!
		@acceleration = Vector!
		@max_velocity = Vector math.huge, math.huge, math.huge
		@drag = Vector!

	update: =>
		@previous.x = @x
		@previous.y = @y
		@pvelocity.x = @velocity.x
		@pvelocity.y = @velocity.y

		if not @velocity\is_zero! or not @acceleration\is_zero!
			@velocity.x = @calculate_velocity @velocity.x, @acceleration.x, @drag.x, @max_velocity.x
			@velocity.y = @calculate_velocity @velocity.y, @acceleration.y, @drag.y, @max_velocity.y
			@velocity.a = @calculate_velocity @velocity.a, @acceleration.a, @drag.a, @max_velocity.a

			@x += (@velocity.x * axel.dt) + ((@pvelocity.x - @velocity.x) * axel.dt / 2)
			@y += (@velocity.y * axel.dt) + ((@pvelocity.y - @velocity.y) * axel.dt / 2)
			@angle += @velocity.a * axel.dt

		@center.x = @x + @width / 2
		@center.y = @y + @height / 2

	calculate_velocity: (velocity, acceleration, drag, max) =>
		if acceleration != 0
			velocity += acceleration * axel.dt
		else
			drag_effect = drag * axel.dt
			if velocity - drag_effect > 0
				velocity -= drag_effect
			elseif velocity + drag_effect < 0
				velocity += drag_effect
			else
				velocity = 0

		if velocity > max
			velocity = max
		elseif velocity < -max
			velocity = -max

		velocity