generate:
	flutter pub run build_runner build --delete-conflicting-outputs

grpc-gen:
	protoc --proto_path=./assets/proto \
    		--dart_out=grpc:lib/models/identity \
    		./assets/proto/user.proto
	protoc --proto_path=./assets/proto \
		--dart_out=grpc:lib/infrastructure/services \
		./assets/proto/identity_grpc.proto