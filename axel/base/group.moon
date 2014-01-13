export class Group extends Entity
	__type: "group"

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

	pre_draw: =>
	post_draw: =>

	draw: =>
		for member in *@members
			if member.exists and member.visible
				member\pre_draw!
				member\draw!
				member\post_draw!