require "test"

test class EntityTest
	axel.dt = 1

	center_test: ->
		e = Entity!
		assert e.center.x == 0
		assert e.center.y == 0

		e = Entity 2, 4
		assert e.center.x == 2
		assert e.center.y == 4

		e = Entity 2, 4, 10, 10
		assert e.center.x == 7
		assert e.center.y == 9

	calculate_simple_velocity_test: ->
		e = Entity!
		assert e\calculate_velocity(0, 1, 0, math.huge) == 1
		assert e\calculate_velocity(0, -1, 0, math.huge) == -1
		assert e\calculate_velocity(0, 0, 0, math.huge) == 0
	
	calculate_max_velocity_test: ->
		e = Entity!
		assert e\calculate_velocity(0, 5, 0, 2) == 2
		assert e\calculate_velocity(0, -5, 0, 2) == -2

	calculate_drag_velocity_test: ->
		e = Entity!
		assert e\calculate_velocity(5, 0, 2, math.huge) == 3
		assert e\calculate_velocity(-5, 0, 2, math.huge) == -3
		assert e\calculate_velocity(5, 0, 22, math.huge) == 0
		assert e\calculate_velocity(-5, 0, 22, math.huge) == 0

	calculate_velocity_on_update_test: ->
		e = Entity!
		e.acceleration.x = 10
		e.acceleration.y = 5
		e\update!
		assert e.x == 5
		assert e.y == 2.5
		e.acceleration\stop!
		e\update!
		assert e.x == 15
		assert e.y == 7.5