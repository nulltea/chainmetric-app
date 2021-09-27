# Chainmetric: Heimdall App

Cross-platform mobile application for the IoT enabled blockchain supply chain controlled by sensor requirements system.

## Requirements
- Flutter local environment
- [protoc](https://grpc.io/docs/protoc-installation) command line utility for gRPC
- [fabnctl](https://github.com/timoth-y/fabnctl) command line utility for generation Fabric config (optionally)
- Google Cloud and Firebase accounts

## Preparation

### Fabric connection config

In order to connect to Hyperledger Fabric network application should have `connection.yaml` config in assets.

It is possible to form such config by hands, please see [connection_template.yaml](https://github.com/timoth-y/chainmetric-app/blob/master/heimdall/assets/connection_template.yaml).

Alternatively, you can use [fabnctl](https://github.com/timoth-y/fabnctl) command line utility for generation. Install it an run following command:

```bash
export NETWORK_PROJECT_PATH /home/repos/fabric-network # path where network-config.yaml located along with crypto materials
make fabric-gen
```

### Google Cloud and Firebase setup

#### Google Maps API

Heimdall app require integration with Google Maps API. Make sure you generate API key (see [Get API key](https://developers.google.com/maps/documentation/maps-static/get-api-key)) and pass it in following locations:

Main config located at `heimdall/assets/config.yaml`:
```yaml
geo_location_api_key: your_key_here
```

Add .env file on path `heimdall/android/.env` with following content:

```bash
MAPS_API_KEY=your_key_here
```

#### Firebase

Add `google-service.json` that can be generated in Firebase console to `heimdall/android/app/google-service.json`.

### Domain related config

Edit configuration on following paths to make Heimdall application applicable to your domain and organizations:

- [heimdall/assets/data](https://github.com/timoth-y/chainmetric-app/tree/master/heimdall/assets/data)
- [heimdall/assets/config.yaml](https://github.com/timoth-y/chainmetric-app/tree/master/heimdall/assets/config_template.yaml)

## Development

To generate JSON related code use `json-gen` make rule:

```bash
make json-gen
```

To generate Protobuf related code use `proto-gen` make rule:

```bash
make proto-gen
```

To sync proto files with [chainmetric-network](https://github.com/timoth-y/chainmetric-network) project use `proto-sync-network` make rule:

```bash
make proto-sync-network
```

## License

Licensed under the [Apache 2.0](https://github.com/timoth-y/chainmetric-network/blob/main/LICENSE).
