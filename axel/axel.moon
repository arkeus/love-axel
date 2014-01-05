class Axel
	new: =>
		@initialized = false
		@love = nil
		@dt = 0

	initialize: (love) =>
		assert @initialized == false, "Game has already been initialized"
		@bind_love love
		@initialized = true

	bind_love: (love) =>
		@love = love
		@love.update = (dt) -> @update dt
		@love.draw = -> @draw!

	update: (dt) =>
		@dt = dt

	draw: =>
		@love.graphics.print("Testing", 10, 10)

export axel = Axel!