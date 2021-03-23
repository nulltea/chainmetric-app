class QRScanException implements Exception {
  final String problem;
  final String cause;

  QRScanException({
    this.problem = "QR code is invalid",
    this.cause = "Something went wrong during scanning QR code"
  });

  @override
  String toString() => "$problem: $cause";
}