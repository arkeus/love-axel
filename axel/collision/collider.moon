export class Collider
	new: =>
		@source_frame = Rectangle!
		@target_frame = Rectangle!
		@source_axis_frame = Rectangle!
		@target_axis_frame = Rectangle!
		@callback = nil
		@comparisons = 0
		@solve_x_collision_callback = @\solve_x_collision

	build: => -- abstract
	overlap: => -- abstract
	reset: => -- abstract

	add_all: (object, group) =>
		if object.__type == "group"
			@add_all entity for entity in *object.members when entity.active and entity.exists
		elseif object != nil
			table.insert group, object

	solve_x_collision: (source, target) =>
		return source\overlap target, @solve_x_collision_callback, true if source.__type == "tilemap"
		return target\overlap source, @solve_x_collision_callback, true if target.__type == "tilemap"

		sfx = source.x - source.previous.x
		tfx = target.x - target.previous.x

		@source_axis_frame.x = if source.x > source.previous.x then source.previous.x else source.x
		@source_axis_frame.y = source.previous.y
		@source_axis_frame.width = source.width + math.abs sfx
		@source_axis_frame.height = source.height

		@target_axis_frame.x = if target.x > target.previous.x then target.previous.x else target.x
		@target_axis_frame.y = target.previous.y
		@target_axis_frame.width = target.width + math.abs tfx
		@target_axis_frame.height = target.height

		overlap = 0
		if (@source_axis_frame.x + @source_axis_frame.width - epsilon > @target_axis_frame.x) and (@source_axis_frame.x + epsilon < @target_axis_frame.x + @target_axis_frame.width) and (@source_axis_frame.y + @source_axis_frame.height - epsilon > @target_axis_frame.y) and (@source_axis_frame.y + epsilon < @target_axis_frame.y + @target_axis_frame.height)
			if sfx > tfx
				overlap = source.x + source.width - target.x
			elseif sfx < tfx
				overlap = source.x - target.width - target.x

		if overlap != 0
			source.x -= overlap
			source.velocity.x = 0
			target.velocity.x = 0
			return true

		return false

	solve_y_collision: (source, target) =>
		solve_y_collision_callback or= @\solve_y_collision

		return source\overlap target, solve_y_collision_callback, true if source.__type == "tilemap"
		return target\overlap source, solve_y_collision_callback, true if target.__type == "tilemap"

		sfy = source.y - source.previous.y
		tfy = target.y - target.previous.y

		@source_axis_frame.x = source.x
		@source_axis_frame.y = if source.y > source.previous.y then source.previous.y else source.y
		@source_axis_frame.width = source.width
		@source_axis_frame.height = source.height + math.abs sfy

		@target_axis_frame.x = target.x
		@target_axis_frame.y = if target.y > target.previous.y then target.previous.y else target.y
		@target_axis_frame.width = target.width
		@target_axis_frame.height = target.height + math.abs tfy

		overlap = 0
		if (@source_axis_frame.x + @source_axis_frame.width - epsilon > @target_axis_frame.x) and (@source_axis_frame.x + epsilon < @target_axis_frame.x + @target_axis_frame.width) and (@source_axis_frame.y + @source_axis_frame.height - epsilon > @target_axis_frame.y) and (@source_axis_frame.y + epsilon < @target_axis_frame.y + @target_axis_frame.height)
			if sfy > tfy
				overlap = source.y + source.height - target.y
			elseif sfy < tfy
				overlap = source.y - target.height - target.y

		if overlap != 0
			source.y -= overlap
			source.velocity.y = 0
			target.velocity.y = 0
			return true
			
		return false