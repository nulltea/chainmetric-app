extension CapExtension on String {
  String get toSentenceCase => '${this[0].toUpperCase()}${this.substring(1)}';
  String get allInCaps => this.toUpperCase();
}
