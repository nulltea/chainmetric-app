generate:
	flutter pub run build_runner build --delete-conflicting-outputs

grpc-gen:
	protoc --dart_out=grpc:lib/models/generated google/protobuf/timestamp.proto
	protoc --dart_out=grpc:lib/models/generated google/protobuf/empty.proto

	protoc \
		-I=./assets/proto \
		-I=${GOPATH}/pkg/mod/github.com/envoyproxy/protoc-gen-validate@v0.6.1 \
		--dart_out=grpc:lib/models/identity \
 		./assets/proto/user.proto
	protoc \
		-I=./assets/proto \
		-I=${GOPATH}/pkg/mod/github.com/envoyproxy/protoc-gen-validate@v0.6.1 \
		--dart_out=grpc:lib/infrastructure/services \
		./assets/proto/identity_grpc.proto

	find . -type f -name '*.pb*.dart' \
		-exec sed -i "s/'user.pb.dart'/'package:chainmetric\/models\/identity\/user.pb.dart'/g" {} +
	find . -type f -name '*.pb*.dart' \
		-exec sed -i "s/google\/protobuf/package:chainmetric\/models\/generated\/google\/protobuf/g" {} +

	rm \
		./lib/infrastructure/services/*.pbenum.dart \
		./lib/infrastructure/services/*.pbjson.dart