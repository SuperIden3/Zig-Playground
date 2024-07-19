SRC = src/main.zig
SRCS = $(SRC) src/root.zig
OUT = zig-out/bin/Zig-Playground
FLAGS = --release -Doptimize=Debug

build: $(SRCS)
	zig build $(FLAGS)
run: build
	./$(OUT)
debug: build
	gdb -q -ex "break main.main" -tui -ex "lay split" -ex "run" ./$(OUT)
clean:
	rm -rf zig-out
all: build
.PHONY: build run debug clean all