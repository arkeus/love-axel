export class Sprite extends Entity
	new: (x = 0, y = 0, graphic = nil, frame_width = 0, frame_height = 0) =>
		super x, y

		@color = Color\white!
		@load graphic, frame_width, frame_height

	load: (graphic, frame_width = 0, frame_height = 0) =>
		@graphic = if graphic then @create_image graphic else nil
		@frame_width = frame_width
		@frame_height = frame_height
		self

	create: (width, height, color = nil) =>
		@graphic = nil
		@frame_width = width
		@frame_height = height
		@color = color or Color\red!
		self

	create_image: (graphic) =>
		love.graphics.newImage(graphic)

	update: =>
		super!

	draw: =>
		love.graphics.setColor @color\values!
		if @graphic then @render_sprite! else @render_rectangle!

	render_sprite: =>
		love.graphics.draw @graphic, @x, @y

	render_rectangle: =>
		love.graphics.rectangle "fill", @x, @y, @frame_width, @frame_height