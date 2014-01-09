export class TimerSet
	new: =>
		@timers = nil

	update: =>
		return if @timers == nil
		dead_timers = 0
		for timer in *@timers
			if not timer.alive
				dead_timers += 1
				continue
			elseif not timer.active
				continue

			timer.timer -= axel.dt
			while timer.timer <= 0
				timer.timer += timer.delay
				timer.times -= 1
				timer.callback!
				if timer.times == 0
					timer\stop!
					break

			if dead_timers >= 5
				for i = #@timers, 1
					table.remove @timers, i unless @timers[i].alive

	add: (delay, times = 1, callback, start = -1) =>
		print "times is #{times}"
		@timers = {} unless @timers
		timer = Timer delay, times, callback, start
		table.insert @timers, timer
		timer

	clear: =>
		@timers[key] = nil for key, _ in *@timers