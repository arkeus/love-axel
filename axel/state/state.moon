export class State extends Group
	new: =>
		super!
		@persistant_update = false
		@persistant_draw = true
		@camera = Camera!

	update: =>
		super!

	draw: =>
		@camera\update!
		super!
		@camera\draw!

	create: => -- Abstract
	on_pause: => -- Abstract
	on_resume: => -- Abstract