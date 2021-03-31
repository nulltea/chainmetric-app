# ChainMetric: Client Application

[![dart badge]][dart]&nbsp;
[![flutter badge]][flutter]&nbsp;
[![android badge]][flutter]&nbsp;
[![commit activity badge]][repo commit activity]&nbsp;
[![license badge]][license url]

## Overview

_**Chainmetric Client Application**_ provides a convenient visual user interface for interacting, managing, and monitoring assets stored on permissioned IoR-enabled blockchain as a part of supply-chain control needs.

Cross-platform application written with the help of Flutter framework provides a way to input assets to the ledger, assign requirements of storing and delivering such assets, monitoring environmental metric readings sourced by [IoT sensor-equipped devices][chainmetric sensorsys repo] and validated by [blockchain network's][chainmetric network repo] [Smart Contracts][chainmetric contracts repo].

[![screenshots]][this repo]

## Tradeoff

Chainmetric application is written using [Flutter][flutter] UI development framework, which provides a convenient way of crafting fast user experiences for mobile, web, and desktop from a single codebase. It's programming language [Dart][dart] has a build in support for [declarative UI][declarative ui] and its massive widget catalog makes Flutter a pretty hot alternative to native mobile development and other hybrid frameworks like React Native or Ionic Angular.

However, Flutter is still a young technology and it's dedicated programming language may not have alternatives for some packages that may be crucial for project. And that is exactly the tradeoff with Chainmetric project, since its blockchain network is build upon [Hyperledger Fabric][hyperledger fabric] stack, which currently does not support client SDK for Dart (only [Go][fabric sdk go], [Python][fabric sdk py], [NodeJS][fabric sdk node], and [Java][fabric sdk java]).

So, the available options here is to skip Flutter in favor of native development, try use JS-based frameworks like React Native, or even implement own SDK on Dart, which actually is not that complicated, since foremost it uses common gRPC protocols communication.

Thankfully, there is one more option which happens to be ideal for this project, which implies in binding Golang-written SDK using [`gomobile`][gomobile] utility to mobile native languages, which this case are Kotlin for Android, and Swift for iOS, and then use call this native functionality from Dart codebase using [Method Channel][method channel]. Even thought this approach seems too complicated at the first glance, it it actually pretty straightforward and works just fine.

## Streaming

The one ambitious feature of current application is too reactively stream environmental metric readings posted on blockchain by sensors-equipped IoT devices, while such data is validated by on-chain [Smart Contracts][chainmetric contracts repo] against previously assigned requirements.

The implementation of such feature requires th combination of Flutter's [Event Channel][event channel] with carefully choreographed event emitters and listeners on each level of system:

[![diagram]][this repo]

## Requirements

- Just a mobile phone and cryptographic credentials to access network

## Wrap up

Chainmetric application implementation manages to connect [modern UI rendering engine][flutter] and [enterprise-grade permissioned blockchain][hyperledger fabric] by utilizing Golang cross-platform capabilities. Such approach allowed to quickly create decent-looking user interface which is truly reactive to changes in the [blockchain network][chainmetric network repo] and allows to made them in any place at any time.

## License

Licensed under the [Apache 2.0][license file].


[dart badge]: https://img.shields.io/badge/Code-Dart-informational?style=flat&logo=dart&logoColor=white&color=50B1AA
[lines counter]: https://img.shields.io/tokei/lines/github/timoth-y/chainmetric-contracts?color=teal&label=Lines
[commit activity badge]: https://img.shields.io/github/commit-activity/m/timoth-y/chainmetric-contracts?label=Commit%20activity&color=teal
[flutter badge]: https://img.shields.io/badge/Framework-Flutter-informational?style=flat&logo=flutter&logoColor=white&color=3374E0
[android badge]: https://img.shields.io/badge/Android-Supported-informational?style=flat&logo=android&logoColor=white&color=87B153
[license badge]: https://img.shields.io/badge/License-Apache%202.0-informational?style=flat&color=blue

[screenshots]: https://github.com/timoth-y/chainmetric-app/blob/master/docs/screenshots.png?raw=true

[this repo]: https://github.com/timoth-y/chainmetric-app
[dart]: https://dart.dev
[flutter]: https://flutter.dev
[repo commit activity]: https://github.com/timoth-y/kicksware-api/graphs/commit-activity
[license url]: https://www.apache.org/licenses/LICENSE-2.0

[declarative ui]: https://flutter.dev/docs/get-started/flutter-for/declarative
[widget catalog]: https://flutter.dev/docs/development/ui/widgets

[hyperledger fabric]: https://www.hyperledger.org/use/fabric
[fabric sdk go]: https://github.com/hyperledger/fabric-sdk-go
[fabric sdk py]: https://github.com/hyperledger/fabric-sdk-py
[fabric sdk node]: https://github.com/hyperledger/fabric-sdk-node
[fabric sdk java]: https://github.com/hyperledger/fabric-sdk-java
[gomobile]: https://github.com/golang/mobile
[method channel]: https://api.flutter.dev/flutter/services/MethodChannel-class.html
[event channel]: https://api.flutter.dev/flutter/services/EventChannel-class.html

[diagram]: https://github.com/timoth-y/chainmetric-app/blob/master/docs/diagram.png?raw=true

[chainmetric network repo]: https://github.com/timoth-y/chainmetric-network
[chainmetric contracts repo]: https://github.com/timoth-y/chainmetric-contracts
[chainmetric sensorsys repo]: https://github.com/timoth-y/chainmetric-sensorsys

[license file]: https://github.com/timoth-y/chainmetric-network/blob/main/LICENSE