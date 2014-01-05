require "test"

test class Scratchpad
	scratch_test: =>
		a = Color 255
		assert a.red == 255
		assert a.green == 0

		a = Color\red!
		assert a.red == 255
		assert a.green == 0