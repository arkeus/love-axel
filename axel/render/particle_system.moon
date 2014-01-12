export class ParticleSystem
	new: =>
		@emitters = Group!
		@lookup = {}

	register: (name, emitter) =>
		@emitters\add emitter
		@lookup[name] = emitter

	emit: (name, x, y, amount) =>
		@lookup[name]\emit x, y, amount

	stream: (name, x, y, amount) =>
		@lookup[name]\stream x, y, amount

	stop: (name) =>
		@lookup[name]\stop!