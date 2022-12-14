all: build

export CXX := clang++
BUILDDIR ?= /tmp/build

.PHONY: build
build:
	cmake -B ${BUILDDIR} -G Ninja .
	cmake --build ${BUILDDIR}

.PHONY: run
run:
	cd ${BUILDDIR} && ./main

.PHONY: test
test:
	ctest --output-on-failure --test-dir ${BUILDDIR}

.PHONY: clean
clean:
	rm -rf ${BUILDDIR}

ifndef VERBOSE
.SILENT:
endif
