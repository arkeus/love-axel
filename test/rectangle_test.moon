require "test"

test class RectangleTest
	zero_test: ->
		r = Rectangle!
		assert r.x == 0
		assert r.y == 0
		assert r.width == 0
		assert r.height == 0

	half_zero_test: ->
		r = Rectangle 1, 2
		assert r.x == 1
		assert r.y == 2
		assert r.width == 0
		assert r.height == 0

	assign_test: ->
		r = Rectangle!
		r.x = 1
		r.y = 2
		r.width = 3
		r.height = 4
		assert r.x == 1
		assert r.y == 2
		assert r.width == 3
		assert r.height == 4

	initialize_test: ->
		r = Rectangle 4, 5, 6, 7
		assert r.x == 4
		assert r.y == 5
		assert r.width == 6
		assert r.height == 7