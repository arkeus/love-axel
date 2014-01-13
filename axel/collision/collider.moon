export class Collider
	new: =>
		@source_frame = Rectangle!
		@target_frame = Rectangle!
		@source_axis_frame = Rectangle!
		@target_axis_frame = Rectangle!
		@callback = nil
		@comparisons = 0
		@solve_x_collision_callback = @\solve_x_collision
		@solve_y_collision_callback = @\solve_y_collision
		@overlap_against_bucket_callback = @\overlap_against_bucket
		@collide_against_bucket_callback = @\collide_against_bucket

	build: => -- abstract
	overlap: => -- abstract
	reset: => -- abstract

	add_all: (object, group) =>
		if object.__type == "group"
			@add_all entity, group for entity in *object.members when entity.active and entity.exists
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
				source.touching.right = true
				target.touching.left = true
			elseif sfx < tfx
				overlap = source.x - target.width - target.x
				target.touching.right = true
				source.touching.left = true

		if overlap != 0
			source.x -= overlap
			source.velocity.x = 0
			target.velocity.x = 0
			return true

		return false

	solve_y_collision: (source, target) =>
		return source\overlap target, @solve_y_collision_callback, true if source.__type == "tilemap"
		return target\overlap source, @solve_y_collision_callback, true if target.__type == "tilemap"

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
				source.touching.down = true
				target.touching.up = true
			elseif sfy < tfy
				overlap = source.y - target.height - target.y
				source.touching.up = true
				target.touching.down = true

		if overlap != 0
			source.y -= overlap
			source.velocity.y = 0
			target.velocity.y = 0
			return true
			
		return false

	build_frame: (frame, entity) =>
		frame.x = if entity.x > entity.previous.x then entity.previous.x else entity.x
		frame.y = if entity.y > entity.previous.y then entity.previous.y else entity.y
		frame.width = entity.x + entity.width - frame.x
		frame.height = entity.y + entity.height - frame.y

	collide_against_bucket: (source, bucket) =>
		return false if not source.solid or not source.active or not source.exists

		overlap_found = false
		@build_frame @source_frame, source

		for target in *bucket
			continue unless target.active and target.exists and target.solid and source != target
			@build_frame @target_frame, target

			if (@source_frame.x + @source_frame.width > @target_frame.x) and (@source_frame.x < @target_frame.x + @target_frame.width) and (@source_frame.y + @source_frame.height > @target_frame.y) and (@source_frame.y < @target_frame.y + @target_frame.height)
				if not target.phased and not source.phased
					collision_found = true if @solve_x_collision source, target
					@callback source, target if @callback

		for target in *bucket
			continue unless target.active and target.exists and target.solid and source != target
			@build_frame @target_frame, target

			if (@source_frame.x + @source_frame.width > @target_frame.x) and (@source_frame.x < @target_frame.x + @target_frame.width) and (@source_frame.y + @source_frame.height > @target_frame.y) and (@source_frame.y < @target_frame.y + @target_frame.height)
				if not target.phased and not source.phased
					collision_found = true if @solve_y_collision source, target
					@callback source, target if @callback

		overlap_found

	overlap_against_bucket: (source, bucket) =>
		overlap_found = false
		@build_frame @source_frame, source

		for target in *bucket
			continue unless target.active and target.exists and target.solid and source != target
			@build_frame @target_frame, target

			if (@source_frame.x + @source_frame.width > @target_frame.x) and (@source_frame.x < @target_frame.x + @target_frame.width) and (@source_frame.y + @source_frame.height > @target_frame.y) and (@source_frame.y < @target_frame.y + @target_frame.height)
				@callback source, target if @callback
				overlap_found = true

		overlap_found