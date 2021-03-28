import 'package:intl/intl.dart';

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

extension DateTimeAgo on DateTime {
  String timeAgoSinceDate({bool numericDates = true}) {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays > 8) {
      return DateFormat("dd-MM-yyyy h:mma").format(this);
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? "1 week ago" : "Last week";
    } else if (difference.inDays >= 2) {
      return "${difference.inDays} days ago";
    } else if (difference.inDays >= 1) {
      return (numericDates) ? "1 day ago" : "Yesterday";
    } else if (difference.inHours >= 2) {
      return "${difference.inHours} hours ago";
    } else if (difference.inHours >= 1) {
      return (numericDates) ? "1 hour ago" : "An hour ago";
    } else if (difference.inMinutes >= 2) {
      return "${difference.inMinutes} minutes ago";
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? "1 minute ago" : "A minute ago";
    } else if (difference.inSeconds >= 3) {
      return "${difference.inSeconds} seconds ago";
    } else {
      return "Just now";
    }
  }
}
