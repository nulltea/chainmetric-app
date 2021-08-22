PROTO_PATH=../../contracts/src

generate:
	flutter pub run build_runner build --delete-conflicting-outputs

proto-cp:
	cp ${PROTO_PATH}/identity/api/presenter/*.proto assets/proto/models/
	cp ${PROTO_PATH}/identity/api/rpc/*.proto assets/proto/services/

	find . -type f -name '*.proto' \
		-exec sed -i "s/identity\/api\/presenter\///g" {} +

grpc-gen:
	protoc --dart_out=grpc:lib/models/generated google/protobuf/timestamp.proto
	protoc --dart_out=grpc:lib/models/generated google/protobuf/empty.proto

	protoc \
		-I=./assets/proto/models \
		-I=${GOPATH}/pkg/mod/github.com/envoyproxy/protoc-gen-validate@v0.6.1 \
		--dart_out=grpc:lib/models/identity \
 		./assets/proto/models/*.proto
	protoc \
		-I=./assets/proto/models \
		-I=./assets/proto/services \
		-I=${GOPATH}/pkg/mod/github.com/envoyproxy/protoc-gen-validate@v0.6.1 \
		--dart_out=grpc:lib/infrastructure/services \
		./assets/proto/services/*.proto

	find . -type f -name '*.pb*.dart' \
		-exec sed -i "s/'\(enrollment\|auth\|user\).pb.dart'/'package:chainmetric\/models\/identity\/\1.pb.dart'/g" {} +
	find . -type f -name '*.pb*.dart' \
		-exec sed -i "s/google\/protobuf/package:chainmetric\/models\/generated\/google\/protobuf/g" {} +

	rm \
		./lib/infrastructure/services/*.pbenum.dart \
		./lib/infrastructure/services/*.pbjson.dart