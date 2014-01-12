export class Emitter extends Entity
	new: (image, buffer) =>
		super!
		@ex = 0
		@ey = 0
		@blend = "additive"
		@ps = love.graphics.newParticleSystem love.graphics.newImage(image), buffer
		@ps\stop!

	emit: (x, y, amount) =>
		@ps\start!
		@ps\setEmissionRate 0
		@ps\setPosition x, y
		@ps\emit amount
		@ps\pause!

	stream: (x, y, amount, duration = -1) =>
		@ps\setEmissionRate amount
		@ps\setEmitterLifetime duration
		@ex = x
		@ey = y
		@ps\start!

	stop: =>
		@ps\pause!

	update: =>
		@ps\setPosition @ex, @ey
		@ps\update axel.dt
		super!

	draw: =>
		love.graphics.draw @ps