export class Camera extends Point
	new: =>
		super!
		@bounds = Rectangle 0, 0, math.huge, math.huge
		@target = nil

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