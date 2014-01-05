export class AnimationSet
	new: =>
		@animation = nil
		@animations = {}

		@frame = 0
		@delay = 0
		@timer = 0

	resize: (width, height, image_width, image_height) =>
		@quads = QuadSet width, height, image_width, image_height

	add: (name, frames, framerate = 15, looped = true, callback = nil) =>
		@animations[name] = Animation name, frames, framerate, looped, callback
		self

	play: (name, reset = false) =>
		if (reset or @animation == nil or (@animation != nil and @animation.name != name)) and @animations[name] != nil
			@animation = @animations[name]
			@delay = 1 / @animation.framerate
			@timer = @delay
			@frame = 0

	show: (frame) =>
		@animation = nil
		@frame = frame

	advance: (dt) =>
		if @animation != nil
			@timer += dt
			while @timer >= @delay
				@timer -= @delay
				if @frame + 1 < #@animation.frames or @animation.looped
					@frame = (@frame + 1) % #@animation.frames
				@animation.callback! if @frame + 1 == #@animation.frames and @animation.callback != nil

	quad: => @quads\get(@frame)

	get: (name) => @animations[name]