export class GroupCollider extends Collider
	new: =>
		super!
		@source_list = {}
		@target_list = {}

	initialize: =>
		@source_list = {}
		@target_list = {}
		@comparisons = 0

	reset: =>
		@source_list[k] = nil for k in pairs @source_list
		@target_list[k] = nil for k in pairs @target_list
		@comparisons = 0

	build: (source, target) =>
		@add_all source, @source_list
		@add_all target, @target_list

	overlap: => @overlap_with_callback @overlap_against_bucket_callback
	collide: => @overlap_with_callback @collide_against_bucket_callback

	overlap_with_callback: (overlap_function) =>
		overlap_found = false
		overlap_found or= overlap_function source, @target_list for source in *@source_list
		return overlap_found