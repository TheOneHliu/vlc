MAKEFLAGS += -j2
CMAKEFLAGS += --parallel=2
PREFIX=$(abspath ./build)

all:  .protoc
	@echo "You are ready to build VLC and its contribs"

include tools.mak
