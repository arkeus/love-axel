export class Keyboard extends Input
	new: =>
		super @@keys

	key_down: (key) =>
		print "Key down #{key}"
		@keys[key] = axel.now

	key_up: (key) =>
		print "Key up #{key}"
		@keys[key] = -axel.now

	@keys: {
		"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s",
		"t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", " ",
		"!", "\"", "#", "$", "&", "'", "(", ")", "*", ",", ".", "/", ":", ";", "<", "=", ">", "?", "@",
		"[", "\\", "]", "^", "_", "`", "kp0", "kp1", "kp2", "kp3", "kp4", "kp5", "kp6", "kp7", "kp8",
		"kp9", "kp.", "kp,", "kp/", "kp*", "kp-", "kp+", "kpenter", "kp=", "up", "down", "right", "left",
		"home", "end", "pageup", "pagedown", "insert", "backspace", "tab", "clear", "return", "delete",
		"f1", "f2", "f3", "f4", "f5", "f6", "f7", "f8", "f9", "f10", "f11", "f12", "f13", "f14", "f15",
		"f16", "f17", "f18", "numlock", "capslock", "scrolllock", "rshift", "lshift", "rctrl", "lctrl",
		"ralt", "lalt", "rgui", "lgui", "mode", "pause", "escape", "help", "printscreen", "sysreq",
		"menu", "application", "power", "currencyunit", "undo"
	}