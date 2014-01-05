export class Color
	new: (@red = 0, @green = 0, @blue = 0, @alpha = 255) =>

	values: => @red, @green, @blue, @alpha

	-- Construct common colors, safe to mutate
	@red: => Color 255
	@green: => Color 0, 255
	@blue: => Color 0, 0, 255
	@white: => Color 255, 255, 255
	@black: => Color!