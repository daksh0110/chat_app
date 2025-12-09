String formatLastMessageTime(DateTime? time) {
  if (time == null) return "-";

  final now = DateTime.now();
  final difference = now.difference(time);

  if (difference.inDays == 0) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }

  if (difference.inDays == 1) {
    return "Yesterday";
  }

  if (now.year == time.year) {
    return "${time.day}/${time.month}";
  }

  return "${time.day}/${time.month}/${time.year}";
}
