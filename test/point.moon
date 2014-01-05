require "test"

test class PointTest
	zero_test: ->
		p = Point!
		assert p.x == 0
		assert p.y == 0

	assign_test: ->
		p = Point!
		p.x = 1
		p.y = 2
		assert p.x == 1
		assert p.y == 2

	initialize_test: ->
		p = Point 4, 5
		assert p.x == 4
		assert p.y == 5