export class AnimationSet
	new: =>
		@animation = nil
		@animations = {}

		@frame = 0
		@delay = 0
		@timer = 0
		@complete = false

	resize: (width, height, image_width, image_height) =>
		@quads = QuadSet width, height, image_width, image_height

	add: (name, frames, framerate = 15, looped = true, callback = nil) =>
		@animations[name] = Animation name, frames, framerate, looped, callback
		self

	play: (name, reset = false) =>
		--print "before"
		if (reset or @animation == nil or (@animation != nil and @animation.name != name)) and @animations[name] != nil
			@animation = @animations[name]
			@delay = 1 / @animation.framerate
			@timer = @delay
			@frame = 1
			@complete = false
		--print "after"

	show: (frame) =>
		@animation = nil
		@frame = frame

	advance: (dt) =>
		if @animation != nil
			@timer += dt
			while @timer >= @delay
				@timer -= @delay
				if @frame < #@animation.frames
					@frame = @frame + 1
				elseif @animation.looped
					@frame = 1
					@animation.callback! if @animation.callback
				elseif not @complete
					@animation.callback! if @animation.callback
					@complete = true

	quad: => @quads\get(if @animation == nil then @frame else @animation.frames[@frame])

	get: (name) => @animations[name]