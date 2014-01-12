export class Debugger extends Group
	new: =>
		super!

		@add with Sprite 0, 0
			\create axel.window_width, 18, Color 0, 0, 0, 180

		@add with Sprite 0, axel.window_height - 18
			\create axel.window_width, 18, Color 0, 0, 0, 180

		@add with @library_text = Text 4, 2, "Love Axel" do nil
		@add with @version_text = Text 0, 2, "Version 1", axel.window_width - 4, "right" do nil
		@add with @fps_text = Text 4, axel.window_height - 16, "FPS: 0" do nil
		@add with @stats_text = Text 0, axel.window_height - 16, "Loading",  axel.window_width - 4, "right" do nil

		for entity in *@members
			entity.scroll\zero!
			entity.zoomable = false

		@active = false

		@draws = 0
		@updates = 0

	reset_stats: =>
		@draws = 0
		@updates = 0

	update: =>
		@fps_text.text = "FPS: #{love.timer.getFPS!}"
		@stats_text.text = "Updates: #{@updates} Draws: #{@draws} [#{axel.states\length!}]"
		super!

		@active = not @active if axel.keys\pressed "`"

	draw: =>
		@pre_draw!
		super!
		@post_draw!