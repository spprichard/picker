build:
	swift build -c release
	mv .build/release/picker /usr/local/bin/
