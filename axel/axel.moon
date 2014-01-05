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

		@states = StateStack!
		@keys = Keyboard!

		print(KeyConstant)

	initialize: (initial_state) =>
		assert @initialized == false, "Game has already been initialized"
		@bind_love!
		@create initial_state
		@initialized = true

	bind_love: =>
		love.update = (dt) -> @update dt
		love.draw = -> @draw!
		love.keypressed = @keys\key_down
		love.keyreleased = @keys\key_up

	create: (initial_state) =>
		@window_width = love.window.getWidth!
		@window_height = love.window.getHeight!
		@width = @window_width
		@height = @window_height
		@states\push initial_state!

	update: (dt) =>
		@previous = @now
		@now = love.timer.getTime!
		@dt = dt
		@states\update!

	draw: =>
		@states\draw!

export axel = Axel!