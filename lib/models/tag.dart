import 'package:flutter/material.dart';

/// Model đại diện cho một tag trong hệ thống
class Tag {
  final String id;
  final String name;
  final Color color;

  const Tag({
    required this.id,
    required this.name,
    required this.color,
  });

  /// Tạo bản sao của tag với các thuộc tính có thể thay đổi
  Tag copyWith({
    String? id,
    String? name,
    Color? color,
  }) {
    return Tag(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
    );
  }

  /// Chuyển đổi Tag thành Map để lưu trữ
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'color': color.value,
    };
  }

  /// Tạo Tag từ Map
  factory Tag.fromMap(Map<String, dynamic> map) {
    return Tag(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      color: Color(map['color'] ?? Colors.blue.value),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Tag && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Tag(id: $id, name: $name, color: $color)';
  }
}
