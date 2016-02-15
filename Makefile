ICED=node_modules/.bin/iced
BUILD_STAMP=build-stamp
WD=`pwd`

default: build
all: build


%.js: %.iced
	$(ICED) -I browserify -c -o `dirname $@` $<

$(BUILD_STAMP): \
	index.js
	./node_modules/.bin/iced ./src/build.iced

build: $(BUILD_STAMP)

clean:
	rm -rf index.js $(BUILD_STAMP)

test:
	$(ICED) test/run.iced

.PHONY: clean test