# Chainmetric: Talos (platfrom interface plugin)

Platfrom interface Flutter plugin for binding Lorkhan gomobile backend with Heimdall application.

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Installation

Add **talos** to your pubspec.yaml:

```yaml
dependencies:
  path: ../talos
```

## Example

### Initialization

Fabric SDK require a wallet to be initialized, it will store user identities.

```dart
await Fabric.initWallet();
```

### x509 Auth

To put x509 credentials into previously initialized wallet use:

```dart
 await Fabric.putX509Identity(organization, cert, key,
          username: username);
```


### Establish connection to the Blockchain

Fabric connection config must be available in app assets. Use its path to first create a config instance:

```dart
final config = await FabricConnection(
            "assets/connection.yaml", IdentitiesRepo.organization!)
        .init();
```


Finally, setup connection with created config:

```dart
 await Fabric.setupConnection(config, channel,
        username: username);
```

### Smart Contracts and transactions

To **evaluate** a transaction to an arbitrary chaincode (Fabric's word for Smart Contract) use:

```dart
final data = await Fabric.evaluateTransaction(
          chaincodeName, txName, args)
```

Supported arguments types are: `String`, `num`, `bool`. For passing multiply arguments use `List` as following:

```dart
final data = await Fabric.evaluateTransaction(
          chaincodeName, txName, ["arg1", true, 1])
```

For passing other types use JSON for serialization to string:

```dart
final data = await Fabric.evaluateTransaction(
          chaincodeName, txName, json.encode(obj1.toJson()))
```

To submit transaction to an arbitrary chaincode use:

```dart
final data = await Fabric.submitTransaction(
          chaincodeName, txName, args)
```

For submitting transaction without needing a response data use:

```dart
final success = await Fabric.trySubmitTransaction(chaincodeName, txName, args)
```

### Vault Auth plugin

Example of using Vault-based authentication:

```dart
final vaultPlugin = VaultAuthenticator(
            "https://vault.example.com")

final success = await vaultPlugin.fetchVaultIdentity(
        organization,
        vaultPath,
        vaultToken,
        username: username,
)
```

### Event-socket connection

To establish even-socket connection see following example:

```dart
 final cancel = EventSocket.bind((event) {
	// Do something cool with event artifact
}, chaincode, args);
```

For this to work chaincode should has `BindToEventSocket` and `CloseEventSocket` methods. Reference can be found [chainmetric-network/smartcontracts/readings](https://github.com/timoth-y/chainmetric-network/blob/main/smartcontracts/readings/event_socket.go).

To simply subscribe to arbitrary events on Fabric network use:

```dart
 final cancel = EventSocket.subscribe((event) {
	// Do something cool with event artifact
}, chaincode, eventName);
```

## License

Licensed under the [Apache 2.0](https://github.com/timoth-y/chainmetric-network/blob/main/LICENSE).