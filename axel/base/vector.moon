export class Vector
	new: (x = 0, y = 0, a = 0) =>
		@x = x
		@y = y
		@a = a

	is_zero: =>
		@x == 0 and @y == 0 and @a == 0

	stop: =>
		@x = 0
		@y = 0
		@a = 0