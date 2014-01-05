export class Input
	new: (keys_list) =>
		@keys = {key, 0 for key in *keys_list}

	check_key: (key) =>
		error "Unknown key #{key}" unless @keys[key]

	down: (key) =>
		@keys[key] > 0

	held: (key) =>
		@down key

	pressed: (key) =>
		@check_key key
		@keys[key] >= axel.previous and @keys[key] < axel.now and axel.previous > 0

	released: (key) =>
		@check_key key
		@keys[key] <= -axel.previous and @keys[key] > -axel.now and axel.previous > 0