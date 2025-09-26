/// Utility class để format ngày tháng
class DateFormatter {
  /// Format ngày tháng theo định dạng Việt Nam
  static String formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Hôm nay ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays == 1) {
      return 'Hôm qua';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} ngày trước';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return weeks == 1 ? '1 tuần trước' : '$weeks tuần trước';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return months == 1 ? '1 tháng trước' : '$months tháng trước';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  /// Format ngày tháng đầy đủ
  static String formatFullDate(DateTime date) {
    final months = [
      'Tháng 1',
      'Tháng 2',
      'Tháng 3',
      'Tháng 4',
      'Tháng 5',
      'Tháng 6',
      'Tháng 7',
      'Tháng 8',
      'Tháng 9',
      'Tháng 10',
      'Tháng 11',
      'Tháng 12'
    ];

    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  /// Format thời gian
  static String formatTime(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  /// Format ngày và giờ
  static String formatDateTime(DateTime date) {
    return '${formatDate(date)} lúc ${formatTime(date)}';
  }
}
