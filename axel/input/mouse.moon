export class Mouse extends Input
	new: =>
		super @@button
		@x = 0
		@y = 0
		@screen = Point!

	mouse_down: (x, y, button) => @keys[button] = axel.now
	mouse_up: (x, y, button) => @keys[button] = -axel.now

	update: (x, y) =>
		camera = axel.states\current!.camera
		@screen.x = x / axel.zoom
		@screen.y = y / axel.zoom
		@x = @screen.x + camera.x
		@y = @screen.y + camera.y

	@button: { "l", "m", "r", "wd", "wu", "x1", "x2" }