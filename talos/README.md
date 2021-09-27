# Chainmetric: Talos Plugin

Platform interface Flutter plugin for binding [Lorkhan](https://github.com/timoth-y/chainmetric-app/tree/master/lorkhan) gomobile backend with [Heimdall](https://github.com/timoth-y/chainmetric-app/tree/master/heimdall) application.

## Rationale

_**Talos plugin**_ allows to interact with Hyperledger Fabric network by wrapping go-written SDK, which binds to platform native-languages (Kotlin, Swift) and provides methods for connecting to Blockchain network, perform transactions, and more features require for mobile app development.

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