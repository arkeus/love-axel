export class FadeCameraEffect extends CameraEffect
	fade: (duration, target_color, camera, callback) =>
		@initialize duration, callback
		@source = camera.sprite.color
		@target = target_color
		@camera = camera

		if @source.alpha == 0
			@red_delta = 0
			@green_delta = 0
			@blue_delta = 0
			@camera.sprite.color.red = @target.red
			@camera.sprite.color.green = @target.green
			@camera.sprite.color.blue = @target.blue
		elseif @target.alpha == 0
			@red_delta = 0
			@green_delta = 0
			@blue_delta = 0
		else
			@red_delta = (@target.red - @source.red) / duration
			@green_delta = (@target.green - @source.green) / duration
			@blue_delta = (@target.blue - @source.blue) / duration

		@alpha_delta = (@target.alpha - @source.alpha) / duration

	update: (camera) =>
		-- might be worth making delta = Color! and doing this via loop
		camera.sprite.color.red += @red_delta * axel.dt
		camera.sprite.color.green += @green_delta * axel.dt
		camera.sprite.color.blue += @blue_delta * axel.dt
		camera.sprite.color.alpha += @alpha_delta * axel.dt
		super camera

	deactivate: =>
		@camera.sprite.color = @target
		super!