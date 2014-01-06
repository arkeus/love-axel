export class GroupCollider extends Collider
	new: =>
		super!
		@source_list = {}
		@target_list = {}

	reset: =>
		@source_list = {}
		@target_list = {}
		@comparisons = 0

	build: (source, target) =>
		@add_all source, @source_list
		@add_all target, @target_list

	overlap: =>
		overlap_found = false
		for source in *@source_list
			continue unless source.active and source.exists
			@comparisons += 1
			@build_frame @source_frame, source

			for target in *@target_list
				continue unless target.acitve and target.exists and source != target
				@build_frame @target_frame, target

				if (@source_frame.x + @source_frame.width > @target_frame.x) and (@source_frame.x < @target_frame.x + @target_frame.width) and (@source_frame.y + @source_frame.height > @target_frame.y) and (@source_frame.y < @target_frame.y + @target_frame.height)
					if source.__type == "tilemap"
						overlap_found = source.overlap target, null
					elseif target.__type == "tilemap"
						overlap_found = target.overlap source, null
					else
						@callback source, target if @callback
						overlap_found = true
		return overlap_found

	collide: =>
		collision_found = false
		for source in *@source_list
			continue unless source.active and source.exists and source.solid
			@comparisons += 1
			@build_frame @source_frame, source

			for target in *@target_list
				continue unless target.active and target.exists and target.solid and source != target
				@build_frame @target_frame, target

				if (@source_frame.x + @source_frame.width > @target_frame.x) and (@source_frame.x < @target_frame.x + @target_frame.width) and (@source_frame.y + @source_frame.height > @target_frame.y) and (@source_frame.y < @target_frame.y + @target_frame.height)
					if not target.phased and not source.phased
						collision_found = true if @solve_x_collision source, target
						@callback source, target if @callback

			for target in *@target_list
				continue unless target.active and target.exists and target.solid and source != target
				@build_frame @target_frame, target

				if (@source_frame.x + @source_frame.width > @target_frame.x) and (@source_frame.x < @target_frame.x + @target_frame.width) and (@source_frame.y + @source_frame.height > @target_frame.y) and (@source_frame.y < @target_frame.y + @target_frame.height)
					if not target.phased and not source.phased
						collision_found = true if @solve_y_collision source, target
						@callback source, target if @callback

		return collision_found

	build_frame: (frame, entity) =>
		frame.x = if entity.x > entity.previous.x then entity.previous.x else entity.x
		frame.y = if entity.y > entity.previous.y then entity.previous.y else entity.y
		frame.width = entity.x + entity.width - frame.x
		frame.height = entity.y + entity.height - frame.y