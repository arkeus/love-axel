require "test"

test class GroupTest
	empty_test: ->
		g = Group!
		assert g\length! == 0

	position_test: ->
		g = Group!
		assert g.x == 0
		assert g.y == 0

		g = Group 1, 2
		assert g.x == 1
		assert g.y == 2

		g = Group!
		g.x = 3
		g.y = 4
		assert g.x == 3
		assert g.y == 4

	simple_add_test: ->
		g = Group!
		e1 = Entity!
		e2 = Entity!

		assert g\length! == 0
		g\add e1
		assert g\length! == 1
		g\add e2
		assert g\length! == 2

	index_test: ->
		g = Group!
		e1 = Entity!
		e2 = Entity!
		e3 = Entity!

		g\add e1
		g\add e2

		assert g\index(e1) == 1
		assert g\index(e2) == 2
		assert g\index(e3) == nil

	remove_test: ->
		g = Group!
		e1 = Entity!
		e2 = Entity!

		g\add e1
		g\add e2

		assert g\length! == 2
		assert g\index(e1) == 1
		assert g\index(e2) == 2

		g\remove e1

		assert g\length! == 1
		assert g\index(e1) == nil
		assert g\index(e2) == 1

		g\remove e2

		assert g\length! == 0
		assert g\index(e1) == nil
		assert g\index(e2) == nil