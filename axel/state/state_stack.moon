export class StateStack
	new: =>
		@states = {}
		@destroyed = {}

	push: (state) =>
		table.insert @states, state
		state\create!
		state

	pop: =>
		previous = table.remove @states
		table.insert @destroyed, previous

	change: (state) =>
		@pop!
		@push state

	current: =>
		error("There are no states on the stack") if #@states == 0
		@states[#@states]

	length: => #@states

	update: =>
		for i, state in pairs @states
			axel.camera = state.camera
			state\update! if i == #@states or state.persistant_update

	draw: =>
		for i, state in pairs @states
			axel.camera = state.camera
			state\draw! if i == #@states or state.persistant_draw