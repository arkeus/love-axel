require "test"

test class VectorTest
	zero_test: ->
		v = Vector!
		assert v.x == 0
		assert v.y == 0
		assert v.a == 0

	assign_test: ->
		v = Vector!
		v.x = 1
		v.y = 2
		v.a = 3
		assert v.x == 1
		assert v.y == 2
		assert v.a == 3

	initialize_test: ->
		v = Vector 4, 5, 6
		assert v.x == 4
		assert v.y == 5
		assert v.a == 6

	is_zero_test: ->
		v = Vector!
		assert v\is_zero!

	is_not_zero_test: ->
		v = Vector 1, 0, 0
		assert not v\is_zero!
		v = Vector 0, 1, 0
		assert not v\is_zero!
		v = Vector 0, 0, 1
		assert not v\is_zero!

	stop_test: ->
		v = Vector 1, 2, 3
		assert not v\is_zero!
		v\stop!
		assert v\is_zero!