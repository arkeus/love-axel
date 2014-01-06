require "test"

test class AxelUtilsTest
	util = AxelUtils!

	clamp_test: ->
		assert util\clamp(5, 2, 10) == 5
		assert util\clamp(5, 7, 10) == 7
		assert util\clamp(5, 2, 4) == 4

	clamp_float_test: ->
		assert util\clamp(5.027, 5.021, 5.034) == 5.027
		assert util\clamp(5.027, 5.029, 5.034) == 5.029
		assert util\clamp(5.027, 5.021, 5.025) == 5.025