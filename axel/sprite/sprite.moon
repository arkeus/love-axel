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
		love.graphics.push!
		love.graphics.setColor @color\values!
		love.graphics.translate @x, @y
		love.graphics.translate @frame_width / 2, @frame_height / 2
		love.graphics.rotate @angle
		love.graphics.translate -@frame_width / 2, -@frame_height / 2
		if @graphic then @render_sprite! else @render_rectangle!
		love.graphics.pop!

	render_sprite: =>
		love.graphics.draw @graphic, 0, 0

	render_rectangle: =>
		love.graphics.rectangle "fill", 0, 0, @frame_width, @frame_height