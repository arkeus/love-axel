export class Camera extends Point
	new: =>
		super!
		@bounds = Rectangle 0, 0, math.huge, math.huge
		@target = nil
		@sprite = Sprite!
		@sprite\create axel.width, axel.height, Color\red!
		@sprite.color.alpha = 0
		-- Singleton Effects
		@fade_effect = FadeCameraEffect!

	set_bounds: (x, y, width, height) => @bounds\set_rectangle x, y, width, height

	follow: (target, padding = nil) =>
		@target = target
		@padding = padding

	update: =>
		if @target != nil
			if @padding == nil
				@x = @target.x + (@target.width - axel.width) / 2
				@y = @target.y + (@target.height - axel.height) / 2
			else
				if @x + @padding.x > @target.x
					@x = @target.x - @padding.x
				elseif @x + @padding.x + @padding.width < @target.x + @target.width
					@x = @target.x + @target.width - @padding.x - @padding.width
				if @y + @padding.y > @target.y
					@y = @target.y - @padding.y
				elseif @y + @padding.y + @padding.height < @target.y + @target.height
					@y = @target.y + @target.height - @padding.y - @padding.height

		@x = if @bounds.width - axel.width < @bounds.x then @bounds.x else axel.util\clamp @x, @bounds.x, @bounds.width - axel.width
		@y = if @bounds.height - axel.height < @bounds.y then @bounds.y else axel.util\clamp @y, @bounds.y, @bounds.height - axel.height

		@fade_effect\update self if @fade_effect.active

	draw: =>
		if @sprite.color.alpha > 0
			@sprite.x = @x
			@sprite.y = @y
			@sprite\pre_draw!
			@sprite\draw!
			@sprite\post_draw!

	fade: (duration, color, callback) =>
		@fade_effect\fade duration, color, self, callback

	fade_out: (duration = 1, color = Color\black!, callback = nil) =>
		@fade duration, color, callback

	fade_in: (duration = 1, callback = nil) =>
		target_color = @sprite.color\clone!
		target_color.alpha = 0
		@fade duration, target_color, callback

	flash: (duration = 1, color = Color\white!, callback = nil) =>
		@fade_out 0, color, ->
			@fade_in duration, callback