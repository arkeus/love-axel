export class Sprite extends Entity
	new: (x = 0, y = 0, graphic = nil, frame_width = 0, frame_height = 0) =>
		super x, y

		@color = Color\white!
		@load graphic, frame_width, frame_height

	load: (graphic, frame_width = 0, frame_height = 0) =>
		@graphic = graphic
		@frame_width = frame_width
		@frame_height = frame_height
		self

	create: (width, height, color = nil) =>
		@graphic = nil
		@frame_width = width
		@frame_height = height
		@color = color or Color\red!
		self

	update: =>
		super!

	draw: =>
		if @graphic then @render_sprite! else @render_rectangle!

	render_sprite: =>
		print "SPRITE!"

	render_rectangle: =>
		love.graphics.setColor @color\values!
		love.graphics.rectangle "fill", @x, @y, @frame_width, @frame_height