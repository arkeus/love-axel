export class Entity extends Rectangle
	__type: "entity"

	new: (x = 0, y = 0, width = 0, height = 0) =>
		super x, y, width, height

		@angle = 0
		@offset = Rectangle!

		@visible = true
		@active = true
		@solid = true
		@exists = true

		@facing = RIGHT
		@flip = LEFT

		@screen = Point!
		@center = Point @x + @width / 2, @y + @height / 2
		@previous = Point @x, @y
		@scroll = Point 1, 1

		@velocity = Vector!
		@pvelocity = Vector!
		@acceleration = Vector!
		@max_velocity = Vector math.huge, math.huge, math.huge
		@drag = Vector!

		@touching = DirectionalSet!
		@touched = DirectionalSet!

		@color = Color\white!
		@zoomable = true
		@timers = TimerSet!
		@blend = "alpha"

	update: =>
		@screen.x = @x - axel.camera.x + @scroll.x
		@screen.y = @y - axel.camera.y + @scroll.y

		@timers\update!
		@touched\copy @touching
		@touching\clear!
		
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

		axel.debugger.updates += 1

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

	destroy: => @exists = false
	revive: => @exists = true

	-- Sets up coordinate system
	pre_draw: =>
		sx = @x - @offset.x
		sy = @y - @offset.y
		cx = axel.camera.x * @scroll.x
		cy = axel.camera.y * @scroll.y

		love.graphics.push!
		
		if not @zoomable
			love.graphics.scale 1 / axel.zoom, 1 / axel.zoom
			cx *= axel.zoom
			cy *= axel.zoom

		love.graphics.setColor @color\values!
		love.graphics.setBlendMode @blend
		--print math.floor(sx - cx + epsilon + 0.5), math.floor(sy - cy + epsilon + 0.5) if @__class == Coin
		--love.graphics.translate round(sx - cx + epsilon), round(sy - cy + epsilon)
		love.graphics.translate sx - cx + epsilon, sy - cy + epsilon

	-- Draw here I doth declare
	draw: => --abstract

	-- Tears down coordinate system
	post_draw: =>
		love.graphics.pop!

	__tostring: => "Entity(#{@x}, #{@y}, #{@width}, #{@height})"

	round = (num) ->
		return math.floor num + 0.5 if num >= 0
		return math.ceil num - 0.5