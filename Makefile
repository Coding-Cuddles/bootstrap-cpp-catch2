all: build

BUILDDIR ?= /tmp/build

.PHONY: build
build:
	CXX=clang++ cmake -B ${BUILDDIR} -G Ninja .
	cmake --build ${BUILDDIR}

.PHONY: test
test:
	ctest --output-on-failure --test-dir ${BUILDDIR}

.PHONY: clean
clean:
	rm -rf ${BUILDDIR}
