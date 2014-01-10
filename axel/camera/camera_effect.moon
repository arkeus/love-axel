export class CameraEffect
	new: =>
		@active = false
		@duration = 0
		@remaining = 0
		@callback = nil

	initialize: (duration, callback) =>
		@duration = duration
		@remaining = duration
		@callback = callback
		@active = true

	update: (camera) =>
		@remaining -= axel.dt
		@deactivate! if @remaining <= 0

	deactivate: =>
		@active = false
		@callback! if @callback