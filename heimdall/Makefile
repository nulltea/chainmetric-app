include .env
export

json-gen:
	flutter pub run build_runner build --delete-conflicting-outputs

proto-sync-network:
	cp ${NETWORK_PROJECT_PATH}/orgservices/*/proto/*.proto assets/proto/models/
	cp ${NETWORK_PROJECT_PATH}/orgservices/*/api/presenter/*.proto assets/proto/models/
	cp ${NETWORK_PROJECT_PATH}/orgservices/*/api/rpc/*.proto assets/proto/services/

	find . -type f -name '*.proto' \
		-exec sed -i "s/orgservices\/.*\/\(api\/presenter\|proto\)\///g" {} +

proto-gen:
	protoc --dart_out=grpc:lib/models/generated google/protobuf/timestamp.proto
	protoc --dart_out=grpc:lib/models/generated google/protobuf/empty.proto

	protoc \
		-I=./assets/proto/models \
		-I=${GOPATH}/pkg/mod/github.com/envoyproxy/protoc-gen-validate@v0.6.1 \
		--dart_out=grpc:lib/models/identity \
 		./assets/proto/models/access.proto \
 		./assets/proto/models/user.proto \
 		./assets/proto/models/admin.proto

	protoc \
		-I=./assets/proto/models \
		-I=${GOPATH}/pkg/mod/github.com/envoyproxy/protoc-gen-validate@v0.6.1 \
		--dart_out=grpc:lib/models/notifications \
		./assets/proto/models/subscription.proto \

	protoc \
		-I=./assets/proto/models \
		--dart_out=grpc:lib/models/generated/common \
		./assets/proto/models/status.proto \

	protoc \
		-I=./assets/proto/models \
		-I=./assets/proto/services \
		-I=${GOPATH}/pkg/mod/github.com/envoyproxy/protoc-gen-validate@v0.6.1 \
		--dart_out=grpc:lib/infrastructure/services \
		./assets/proto/services/*.proto

	find . -type f -name '*.pb*.dart' \
		-exec sed -i "s/'\(access\|user\|admin\).pb.dart'/'package:chainmetric\/models\/identity\/\1.pb.dart'/g" {} +
	find . -type f -name '*.pb*.dart' \
			-exec sed -i "s/'subscription.pb.dart'/'package:chainmetric\/models\/notifications\/subscription.pb.dart'/g" {} +
	find . -type f -name '*.pb*.dart' \
			-exec sed -i "s/'status.pb.dart'/'package:chainmetric\/models\/generated\/common\/status.pb.dart'/g" {} +
	find . -type f -name '*.pb*.dart' \
		-exec sed -i "s/google\/protobuf/package:chainmetric\/models\/generated\/google\/protobuf/g" {} +

	rm \
		./lib/infrastructure/services/*.pbenum.dart \
		./lib/infrastructure/services/*.pbjson.dart

fabric-gen:
	fabnctl gen connection -f ${NETWORK_PROJECT_PATH}/network-config.yaml -n heimdall-applicatiion \
		-c supply-channel -o chipa-inu ${NETWORK_PROJECT_PATH}
	mv connection.yaml assets/connection.yaml