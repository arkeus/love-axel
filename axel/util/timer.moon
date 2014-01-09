export class Timer
	new: (@delay, @times = 1, @callback, start = -1) =>
		@timer = if start < 0 then @delay else start
		@active = true
		@alive = true

	pause: =>
		return self unless @alive
		@active = false
		self

	start: =>
		return self unless @alive
		@active = true
		self

	stop: =>
		@active = false
		@alive = false
		self