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
		@mouse = Mouse!
		@util = AxelUtils!

	initialize: (initial_state, zoom) =>
		assert @initialized == false, "Game has already been initialized"
		@bind_love!

		@window_width = love.window.getWidth!
		@window_height = love.window.getHeight!
		@zoom = zoom
		@width = @window_width / @zoom
		@height = @window_height / @zoom
		
		@states\push initial_state!
		@initialized = true

	bind_love: =>
		love.update = (dt) -> @update dt
		love.draw = -> @draw!
		love.keypressed = @keys\key_down
		love.keyreleased = @keys\key_up
		love.mousepressed = @mouse\mouse_down
		love.mousereleased = @mouse\mouse_up
		love.graphics.setDefaultFilter "nearest", "nearest"

	update: (dt) =>
		@previous = @now
		@now = love.timer.getTime!
		@dt = dt
		@mouse\update love.mouse.getPosition!
		@states\update!

	draw: =>
		love.graphics.origin!
		love.graphics.scale @zoom, @zoom
		@states\draw!

export axel = Axel!