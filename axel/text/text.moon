export class Text extends Entity
	new: (x = 0, y = 0, @text = "", @width = 0, @align = "left") =>
		super math.floor(x), math.floor(y), @width
		@width = math.huge if @width == 0

	draw: =>
		axel.debugger.draws += 1
		love.graphics.printf @text, 0, 0, @width, @align