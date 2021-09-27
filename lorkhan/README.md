# Chainmetric: Lorkhan (gomobile backend) 

Chainmetric infrastructure is build upon [Hyperledger Fabric][hyperledger fabric], the distributed ledger framework for building permissioned Blockchain networks.

However, Fabric currently does not support client SDK for Dart (only [Go][fabric sdk go], [Python][fabric sdk py], [NodeJS][fabric sdk node], and [Java][fabric sdk java]).

_**Chainmetric Lorkhan**_ provides a solution for this problem in form of an embedded [gomobile][gomobile] driver, which is binded to platform native languages (Kotlin and Swift) and is wrapped by [Talos plugin][talos plugin].

[hyperledger fabric]: https://www.hyperledger.org/use/fabric
[fabric sdk go]: https://github.com/hyperledger/fabric-sdk-go
[fabric sdk py]: https://github.com/hyperledger/fabric-sdk-py
[fabric sdk node]: https://github.com/hyperledger/fabric-sdk-node
[fabric sdk java]: https://github.com/hyperledger/fabric-sdk-java
[talos plugin]: https://github.com/timoth-y/chainmetric-app/tree/master/talos

## Library reference

Lorkhan introduces methods for integrating with Fabric blockchain, as well as additional plugins for providing common mobile features like authentication, socket connection, and more.

### Hyperledger Fabric SDK

Being a wrapper on [hyperledger/fabric-sdk-go](https://github.com/hyperledger/fabric-sdk-go) Lorkhan make it possible to establish connection to Blockchain network, authenticate with x509 credentials, evaluate and submit transactions on arbitrary Smart Contracts.

### Authentication with HashiCorp Vault

With intention to simplify authentication and identity management Lorkhan also introduces integration with [HashiCorp Vault](https://www.hashicorp.com/products/vault) allowing developer to implement basic auth with userpass credentials and delegate x509 certificates management to Vault.

See details at [chainmetric-network/orgservices/identity](https://github.com/timoth-y/chainmetric-network/tree/main/orgservices/identity).

### Event-socket connection

Event-socket is a implementation of the WebSocket protocol that makes it possible to open a two-way interactive communication session between the user's application and a Blockchain ledger in an event-driven way, which is native to Hyperledger Fabric stack.

See example at [Environment monitoring](https://github.com/timoth-y/chainmetric-app/tree/github/update_readme#environment-monitoring).

## Development

Lorkhan can be compiled into native platform binaries via [gomobile][gomobile] tool.

For Android use:

```bash
make bind-android
```

For iOS use:

```bash
make bind-ios
```

[gomobile]: https://github.com/golang/mobile

## License

Licensed under the [Apache 2.0](https://github.com/timoth-y/chainmetric-network/blob/main/LICENSE).