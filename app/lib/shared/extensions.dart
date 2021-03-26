extension CapExtension on String {
  String toSentenceCase() => '${this[0].toUpperCase()}${this.substring(1)}';
}

extension DurationFormatter on Duration {
  String toShortString() {
    return [
      this.inHours,
      this.inMinutes.remainder(60),
      this.inSeconds.remainder(60)
    ].map((seg) {
      return seg.toString().padLeft(2, '0');
    }).join(':');
  }
}
