export class DirectionalSet
	new: (@left = false, @right = false, @up = false, @down = false) =>

	clear: =>
		@left = false
		@right = false
		@up = false
		@down = false

	any: => @left or @right or @up or @down

	copy: (other) =>
		@left = other.left
		@right = other.right
		@down = other.down
		@up = other.up

	__tostring: =>
		"Left=#{@left}, Right=#{@right}, Up=#{@up}, Down=#{@down}"