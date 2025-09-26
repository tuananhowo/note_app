import 'tag.dart';

/// Model đại diện cho một ghi chú trong hệ thống
class Note {
  final String id;
  final String title;
  final String content;
  final List<Tag> tags;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Note({
    required this.id,
    required this.title,
    required this.content,
    required this.tags,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Tạo bản sao của note với các thuộc tính có thể thay đổi
  Note copyWith({
    String? id,
    String? title,
    String? content,
    List<Tag>? tags,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Cập nhật note với thời gian updatedAt mới
  Note updateWith({
    String? title,
    String? content,
    List<Tag>? tags,
  }) {
    return copyWith(
      title: title,
      content: content,
      tags: tags,
      updatedAt: DateTime.now(),
    );
  }

  /// Chuyển đổi Note thành Map để lưu trữ
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'tags': tags.map((tag) => tag.toMap()).toList(),
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  /// Tạo Note từ Map
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      tags: (map['tags'] as List<dynamic>?)
              ?.map((tagMap) => Tag.fromMap(tagMap as Map<String, dynamic>))
              .toList() ??
          [],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] ?? 0),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] ?? 0),
    );
  }

  /// Kiểm tra xem note có tag cụ thể không
  bool hasTag(String tagId) {
    return tags.any((tag) => tag.id == tagId);
  }

  /// Lấy danh sách tên tags
  List<String> get tagNames => tags.map((tag) => tag.name).toList();

  /// Kiểm tra xem note có rỗng không
  bool get isEmpty => title.trim().isEmpty && content.trim().isEmpty;

  /// Kiểm tra xem note có hợp lệ không
  bool get isValid => title.trim().isNotEmpty;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Note && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Note(id: $id, title: $title, content: $content, tags: $tags, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
