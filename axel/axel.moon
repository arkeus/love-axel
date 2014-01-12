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
		@camera = nil

		@states = StateStack!
		@keys = Keyboard!
		@mouse = Mouse!
		@util = AxelUtils!

	initialize: (initial_state, zoom) =>
		assert love._version_major >= 0 and love._version_minor >= 9, "Axel requires Löve 0.9.0 and above"
		assert @initialized == false, "Game has already been initialized"
		@bind_love!

		math.randomseed os.time!

		@window_width = love.window.getWidth!
		@window_height = love.window.getHeight!
		@zoom = zoom
		@width = @window_width / @zoom
		@height = @window_height / @zoom
		@debugger = Debugger!
		@particle = ParticleSystem!

		@create!
		@states\push initial_state!
		@initialized = true

	create: => -- abstract

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
		@debugger\reset_stats!
		@states\update!

	draw: =>
		love.graphics.origin!
		love.graphics.scale @zoom, @zoom
		@states\draw!
		@debugger\update!
		@debugger\draw! if @debugger.active

	overlap: (source, target, callback = nil, collider = nil) => @overlap_or_collide source, target, callback, collider, false
	collide: (source, target, callback = nil, collider = nil) => @overlap_or_collide source, target, callback, collider, true

	overlap_or_collide: (source, target, callback, collider, collide) =>
		if collider == nil
			collider = if source.__type == "tilemap" or target.__type == "tilemap"
				GroupCollider!
			else
				GridCollider @width, @height
		else
			collider\reset!

		collider.callback = callback
		collider\build source, target
		return if collide then collider\collide! else collider\overlap!

export axel = Axel!
