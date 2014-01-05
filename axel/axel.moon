class Axel
	new: =>
		@initialized = false
		@dt = 0
		@now = 0
		@previous = 0
		@width = 0
		@height = 0
		@window_width = 0
		@window_height = 0
		@zoom = 1

		@states = StateStack!
		@keys = Keyboard!

		print(KeyConstant)

	initialize: (initial_state, zoom) =>
		assert @initialized == false, "Game has already been initialized"
		@bind_love!
		@window_width = love.window.getWidth!
		@window_height = love.window.getHeight!
		@width = @window_width
		@height = @window_height
		@states\push initial_state!
		@zoom = zoom
		@initialized = true

	bind_love: =>
		love.update = (dt) -> @update dt
		love.draw = -> @draw!
		love.keypressed = @keys\key_down
		love.keyreleased = @keys\key_up

	update: (dt) =>
		@previous = @now
		@now = love.timer.getTime!
		@dt = dt
		@states\update!

	draw: =>
		love.graphics.origin!
		love.graphics.scale @zoom, @zoom
		@states\draw!

export axel = Axel!