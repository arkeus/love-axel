export class AxelUtils
	clamp: (value, min, max) =>
		return max if value > max
		return min if value < min
		return value

export epsilon = 0.00001