export class State extends Group
	new: =>
		super!
		@persistant_update = false
		@persistant_draw = true

	create: => -- Abstract
	on_pause: => -- Abstract
	on_resume: => -- Abstract