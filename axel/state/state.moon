export class State extends Group
	new: =>
		super!
		@persistant_update = false
		@persistant_draw = true
		@camera = Camera!

	update: =>
		super!
		@camera\update!

	draw: =>
		love.graphics.push!
		love.graphics.translate -@camera.x, -@camera.y
		super!
		love.graphics.pop!

	create: => -- Abstract
	on_pause: => -- Abstract
	on_resume: => -- Abstract