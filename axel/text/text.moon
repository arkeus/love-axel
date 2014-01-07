export class Text extends Entity
	new: (x = 0, y = 0, @text = "", @width = 0, @align = "left") =>
		super x, y

	draw: =>
		love.graphics.printf @text, @x, @y, @width, @align