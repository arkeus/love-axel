export class Sprite extends Entity
	new: (x = 0, y = 0, graphic = nil, frame_width = 0, frame_height = 0) =>
		super x, y

		@color = Color\white!
		@scale = Point 1, 1
		@animations = AnimationSet!

		if graphic
			@load graphic, frame_width, frame_height
		else
			@create 10, 10

	load: (graphic, frame_width = 0, frame_height = 0) =>
		@graphic = @create_image graphic
		if frame_width == 0 or frame_height == 0
			@frame_width = @graphic\getWidth!
			@frame_height = @graphic\getHeight!
		else
			@frame_width = frame_width
			@frame_height = frame_height
		@animations\resize @frame_width, @frame_height, @graphic\getWidth!, @graphic\getHeight!
		self

	create: (width, height, color = nil) =>
		@graphic = nil
		@frame_width = width
		@frame_height = height
		@color = color or Color\red!
		self

	create_image: (graphic) =>
		love.graphics.newImage graphic

	update: =>
		super!
		@animations\advance axel.dt

	draw: =>
		love.graphics.push!
		love.graphics.setColor @color\values!
		love.graphics.translate @x, @y
		love.graphics.translate @frame_width / 2, @frame_height / 2
		love.graphics.rotate @angle
		love.graphics.translate -@frame_width / 2, -@frame_height / 2
		if @graphic then @render_sprite! else @render_rectangle!
		love.graphics.pop!

	render_sprite: =>
		love.graphics.draw @graphic, @animations\quad!, 0, 0

	render_rectangle: =>
		width = if @frame_width == 0 then 10 else @frame_width
		height = if @frame_height == 0 then 10 else @frame_height
		love.graphics.rectangle "fill", 0, 0, width, height