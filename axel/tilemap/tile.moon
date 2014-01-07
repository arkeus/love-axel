export class Tile
	new: (@map, @index, @solid) =>
		@callback = nil
		@properties = {}