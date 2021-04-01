import 'package:flutter/services.dart';
import 'package:chainmetric/model/auth_model.dart';
import 'package:path_provider/path_provider.dart';

const BLOCKCHAIN_CHANNEL = "chainmetric.app.blockchain-native-sdk";

class Blockchain {
  static final _nativeSDK = MethodChannel(BLOCKCHAIN_CHANNEL);

  static Future<void> initWallet() async {
    final dir = await getApplicationDocumentsDirectory();
    try {
      await _nativeSDK.invokeMethod("wallet_init", {
        "path": "${dir.path}/wallet"
      });
    } on PlatformException catch (e) {
      print("PlatformException: ${e.message}");
    }
  }

  static Future<bool> authRequired() async {
    try {
      return await _nativeSDK.invokeMethod("auth_required");
    } on PlatformException catch (e) {
      print("PlatformException: ${e.message}");
    }
    return true;
  }

  static Future<bool> authenticate(AuthCredentials credentials) async {
    try {
      await _nativeSDK.invokeMethod("auth_identity", {
        "orgID": credentials.organization,
        "cert": credentials.certificate,
        "key": credentials.privateKey
      });
      return true;
    } on PlatformException catch (e) {
      print("PlatformException: ${e.message}");
    }
    return false;
  }

  static Future<bool> initConnection(String channel) async {
    try {
      await _nativeSDK.invokeMethod("connection_init", {
        "config": await getConfig(),
        "channel": channel
      });
      return true;
    } on PlatformException catch (e) {
      print("PlatformException: ${e.message}");
    }
    return false;
  }

  static Future<String> evaluateTransaction(String contract, String method, [String args]) async {
    try {
      return await _nativeSDK.invokeMethod("transaction_evaluate", {
        "contract": contract,
        "method": method,
        "args": args,
      });
    } on PlatformException catch (e) {
      print("PlatformException: ${e.message}");
    }
    return null;
  }

  static Future<String> submitTransaction(String contract, String method, [String args]) async {
    try {
      return await _nativeSDK.invokeMethod("transaction_submit", {
        "contract": contract,
        "method": method,
        "args": args,
      });
    } on PlatformException catch (e) {
      print("PlatformException: ${e.message}");
    }
    return null;
  }

  static Future<bool> trySubmitTransaction(String contract, String method, [String args]) async {
    try {
      await _nativeSDK.invokeMethod("transaction_submit", {
        "contract": contract,
        "method": method,
        "args": args,
      });
      return true;
    } on PlatformException catch (e) {
      print("PlatformException: ${e.message}");
    }
    return false;
  }

  static Future<String> getConfig() async {
    final dir = await getApplicationDocumentsDirectory();
    return """
name: iot-blockchain-supplier
version: 1.0.0
client:
  organization: Supplier
  connection:
    timeout:
      peer:
        endorser: '300'
  credentialStore:
    cryptoStore:
      path: ${dir.path}
organizations:
  Supplier:
    mspid: supplierMSP
    peers:
      - peer0.supplier.iotchain.network
    certificateAuthorities:
      - ca.supplier.iotchain.network
peers:
  peer0.supplier.iotchain.network:
    url: grpcs://peer0.supplier.iotchain.network:443
    tlsCACerts:
      pem: |
            -----BEGIN CERTIFICATE-----
            MIICfzCCAiSgAwIBAgIRAKqlrJdv9xXejtjOZhfAL6IwCgYIKoZIzj0EAwIwgYgx
            CzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpDYWxpZm9ybmlhMRYwFAYDVQQHEw1TYW4g
            RnJhbmNpc2NvMSIwIAYDVQQKExlzdXBwbGllci5pb3RjaGFpbi5uZXR3b3JrMSgw
            JgYDVQQDEx90bHNjYS5zdXBwbGllci5pb3RjaGFpbi5uZXR3b3JrMB4XDTIxMDIw
            MzE4MzUwMFoXDTMxMDIwMTE4MzUwMFowgYgxCzAJBgNVBAYTAlVTMRMwEQYDVQQI
            EwpDYWxpZm9ybmlhMRYwFAYDVQQHEw1TYW4gRnJhbmNpc2NvMSIwIAYDVQQKExlz
            dXBwbGllci5pb3RjaGFpbi5uZXR3b3JrMSgwJgYDVQQDEx90bHNjYS5zdXBwbGll
            ci5pb3RjaGFpbi5uZXR3b3JrMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEKCN3
            JZXBQmCEMAZ05kMr6o+r9muLIkegKFLIb12s6FT/D8E1iIbyvPl+dtBfDeBzWzba
            9PIbKxSCj3uMMDgIyqNtMGswDgYDVR0PAQH/BAQDAgGmMB0GA1UdJQQWMBQGCCsG
            AQUFBwMCBggrBgEFBQcDATAPBgNVHRMBAf8EBTADAQH/MCkGA1UdDgQiBCBMT1oj
            +qYtI4lFlOof6c0uh7lHXjTP8GFSV2Cp77dJAzAKBggqhkjOPQQDAgNJADBGAiEA
            tr8Xq7o+qSaD2WwasHfCi9N2fyCWtO03PCAIGwaNxMoCIQCJmnypJJPgKNL25qa6
            RD9K+IGYhEbmgaNX7BARW2DKgg==
            -----END CERTIFICATE-----
    grpcOptions:
      ssl-target-name-override: peer0.supplier.iotchain.network
      hostnameOverride: peer0.supplier.iotchain.network
certificateAuthorities:
  ca.supplier.iotchain.network:
    url: https://ca.supplier.iotchain.network:443
    caName: ca-supplier
    tlsCACerts:
      pem:
        - |
          -----BEGIN CERTIFICATE-----
          MIICeDCCAh2gAwIBAgIQUqsmXxubBxOrvcRRMOexujAKBggqhkjOPQQDAjCBhTEL
          MAkGA1UEBhMCVVMxEzARBgNVBAgTCkNhbGlmb3JuaWExFjAUBgNVBAcTDVNhbiBG
          cmFuY2lzY28xIjAgBgNVBAoTGXN1cHBsaWVyLmlvdGNoYWluLm5ldHdvcmsxJTAj
          BgNVBAMTHGNhLnN1cHBsaWVyLmlvdGNoYWluLm5ldHdvcmswHhcNMjEwMjAzMTgz
          NTAwWhcNMzEwMjAxMTgzNTAwWjCBhTELMAkGA1UEBhMCVVMxEzARBgNVBAgTCkNh
          bGlmb3JuaWExFjAUBgNVBAcTDVNhbiBGcmFuY2lzY28xIjAgBgNVBAoTGXN1cHBs
          aWVyLmlvdGNoYWluLm5ldHdvcmsxJTAjBgNVBAMTHGNhLnN1cHBsaWVyLmlvdGNo
          YWluLm5ldHdvcmswWTATBgcqhkjOPQIBBggqhkjOPQMBBwNCAAQ+oDhkiMdnWpF7
          JRlOOYyfMgDRy13gjvdvzkK5UbzQhu76U43XTp3sKJVF+/EMrfTWtQnwc91a8G97
          dBiXspbEo20wazAOBgNVHQ8BAf8EBAMCAaYwHQYDVR0lBBYwFAYIKwYBBQUHAwIG
          CCsGAQUFBwMBMA8GA1UdEwEB/wQFMAMBAf8wKQYDVR0OBCIEIPVUOrXBWin6UK20
          dOtzoru91G1X88PPvddO6zgGNpR1MAoGCCqGSM49BAMCA0kAMEYCIQDrsYNkMacS
          iB8s2KAFnVky235pN5NZ0I9BkY/20luc4AIhAPbiu7JIUoteLUmHjU+rD74/Py8P
          pKj9NVByR+Yt/C3o
          -----END CERTIFICATE-----
    httpOptions:
      verify: false
    """;
  }
}
