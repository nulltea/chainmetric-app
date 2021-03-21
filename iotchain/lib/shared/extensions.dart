extension CapExtension on String {
  String toSentenceCase() => '${this[0].toUpperCase()}${this.substring(1)}';
}
