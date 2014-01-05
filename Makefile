all::
	moonc -t build .

test: all
	cd build/test && lua all.lua