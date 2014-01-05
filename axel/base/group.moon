export class Group extends Entity
	new: (x, y) =>
		super x, y
		@members = {}

	add: (entity) =>
		assert entity != nil, "Cannot add nil entities to group"
		table.insert @members, entity
		self

	remove: (entity) =>
		index = @index entity
		return self if index == nil
		table.remove @members, index
		self

	index: (entity) =>
		for i, item in ipairs @members
			return i if item == entity
		return nil

	length: => #@members

	update: =>
		super!
		for member in *@members
			member\update! if member.exists and member.active

	draw: =>
		for member in *@members
			member\draw! if member.exists and member.visible