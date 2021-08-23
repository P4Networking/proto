.PHONY: all proto clean

OS:=$(shell uname)

# PROTO file compiler
PROTOC:=protoc

# compile target define
PROTO:=proto
BFRT:=$(PROTO)/bfruntime.proto
GRPC:=$(PROTO)/google/rpc/*
COMM:=$(PROTO)/common.proto

# stream editor target define
TARGET:=go/p4/bfruntime.pb.go
SED_OBJ:=
ifeq ($(OS), Linux)
	SED_OBJ:='s/"google\/rpc"/"google.golang.org\/genproto\/googleapis\/rpc\/status"/g'
else
	SED_OBJ:= '' 's/"google\/rpc"/"google.golang.org\/genproto\/googleapis\/rpc\/status"/g'
endif

all: proto

# the output files will be placed at the package path in proto files.

proto:
	@echo "\033[32m----- Compiling BFRT proto file -----\033[0m"
	$(PROTOC) $(BFRT) $(GRPC) --go-grpc_out=. --go_out=. -Iproto
	$(PROTOC) $(COMM) --go_out=. -Iproto
	sed -i $(SED_OBJ) $(TARGET)

clean:
	@echo "\033[32m----- Clear all environment -----\033[0m"
	rm go/p4/*

