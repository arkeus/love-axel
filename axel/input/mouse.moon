export class Mouse extends Input
	new: =>
		super @@button
		@x = 0
		@y = 0

	mouse_down: (x, y, button) => @keys[button] = axel.now
	mouse_up: (x, y, button) => @keys[button] = -axel.now

	update: (x, y) =>
		@x = x / axel.zoom
		@y = y / axel.zoom

	@button: { "l", "m", "r", "wd", "wu", "x1", "x2" }