.PHONY: all proto clean

all: proto

proto:
	@echo "\033[32m----- Compiling BFRT proto file -----\033[0m"
	protoc proto/bfruntime.proto proto/google/rpc/* --go-grpc_out=. --go_out=. -Iproto
	protoc proto/common.proto --go_out=. -Iproto
	sed -i '' 's/"google\/rpc"/"google.golang.org\/genproto\/googleapis\/rpc\/status"/g' go/p4/bfruntime.pb.go

clean:
	@echo "\033[32m----- Clear all environment -----\033[0m"
	rm go/p4/*
