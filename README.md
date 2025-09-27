# 📝 Notes Manager

Ứng dụng quản lý ghi chú được phát triển bằng Flutter, hỗ trợ đa nền tảng với giao diện hiện đại và tính năng phân loại bằng tag.

## 🎯 Tổng quan

**Notes Manager** là ứng dụng quản lý ghi chú với các tính năng:
- ✅ Tạo, chỉnh sửa, xóa ghi chú
- ✅ Hệ thống tag phân loại với màu sắc
- ✅ Tìm kiếm và lọc ghi chú
- ✅ Giao diện 2 cột: Sidebar + Editor
- ✅ Hỗ trợ đa nền tảng (Android, iOS, Web, Desktop)

## 🏗️ Kiến trúc

### Pattern: MVVM + Repository
```
UI (Views/Widgets) 
    ↓
ViewModel (Business Logic)
    ↓  
Service (Validation & Processing)
    ↓
Repository (Data Access)
    ↓
Data Source (In-Memory)
```

### Cấu trúc thư mục
```
lib/
├── main.dart                 # Entry point & DI setup
├── models/                   # Data models
│   ├── note.dart            # Note entity
│   ├── tag.dart              # Tag entity  
│   └── app_state.dart        # Application state
├── repositories/             # Data access layer
│   └── notes_repository.dart
├── services/                 # Business logic layer
│   └── notes_service.dart
├── viewmodels/              # Presentation logic
│   └── notes_viewmodel.dart
├── views/                   # UI screens
│   └── notes_home_page.dart
├── widgets/                 # Reusable components
│   ├── notes_sidebar.dart
│   ├── notes_editor.dart
│   └── empty_state.dart
└── utils/                   # Utilities
    ├── constants.dart
    └── date_formatter.dart
```

## 🚀 Tính năng chính

### Quản lý ghi chú
- Tạo ghi chú mới với tiêu đề và nội dung
- Chỉnh sửa ghi chú hiện có
- Xóa ghi chú (có xác nhận)
- Hiển thị danh sách ghi chú với preview
- Tự động cập nhật thời gian tạo/sửa

### Hệ thống Tag
- 5 tag mặc định: Công việc, Cá nhân, Học tập, Quan trọng, Ý tưởng
- Gán nhiều tag cho một ghi chú
- Hiển thị tag với màu sắc phân biệt
- Lọc ghi chú theo tag

### Tìm kiếm & Lọc
- Tìm kiếm theo tiêu đề, nội dung, tag
- Lọc theo tag cụ thể
- Xóa bộ lọc để xem tất cả

## 🛠️ Công nghệ

- **Framework**: Flutter 3.x
- **Language**: Dart 2.19.6+
- **UI**: Material Design 3
- **State Management**: ChangeNotifier
- **Architecture**: MVVM + Repository Pattern

## 📱 Platform Support

- ✅ Android
- ✅ iOS  
- ✅ Web
- ✅ macOS
- ✅ Windows
- ✅ Linux

## 🚀 Getting Started

### Yêu cầu
- Flutter SDK >=2.19.6
- Dart SDK
- IDE (VS Code, Android Studio, IntelliJ)

### Cài đặt
```bash
# Clone repository
git clone <repository-url>
cd note_app

# Cài đặt dependencies
flutter pub get

# Chạy ứng dụng
flutter run
```

### Build cho các platform
```bash
# Android
flutter build apk

# iOS
flutter build ios

# Web
flutter build web

# Desktop
flutter build windows
flutter build macos
flutter build linux
```

## 📊 Data Models

### Note
```dart
class Note {
  String id;           // Unique identifier
  String title;        // Note title (max 200 chars)
  String content;      // Note content (max 10000 chars)
  List<Tag> tags;      // Associated tags
  DateTime createdAt;  // Creation timestamp
  DateTime updatedAt;  // Last modification timestamp
}
```

### Tag
```dart
class Tag {
  String id;           // Unique identifier
  String name;          // Tag name
  Color color;          // Display color
}
```

## 🔧 Validation & Error Handling

- **Input Validation**: Tiêu đề bắt buộc (max 200 chars), nội dung (max 10,000 chars)
- **Error Handling**: Service layer validation với user-friendly messages
- **Loading States**: Hiển thị loading indicators
- **Notifications**: Snackbar cho success/error messages

## 🎨 UI/UX Features

- **Design System**: Material 3 với blue primary color
- **Layout**: 2 cột responsive (Sidebar 300px + Editor)
- **Interactive**: Hover effects, selected states, confirmations
- **Empty States**: Hướng dẫn người dùng khi chưa có dữ liệu

## 📈 Performance

- **Current**: In-memory storage với simulated network delays
- **Future**: Database integration, cloud sync, offline support
- **Optimization**: Efficient list rendering, lazy loading

## 🔮 Roadmap

### Short-term
- [ ] Tìm kiếm nâng cao
- [ ] Export/Import ghi chú
- [ ] Dark mode
- [ ] Keyboard shortcuts

### Long-term
- [ ] Database persistence
- [ ] Cloud synchronization
- [ ] Collaboration features
- [ ] Rich text editing
- [ ] File attachments

## 🧪 Testing

```bash
# Chạy tests
flutter test

# Chạy với coverage
flutter test --coverage
```

## 📄 License

Private project - All rights reserved

## 👥 Contributing

1. Fork the repository
2. Create feature branch
3. Commit changes
4. Push to branch
5. Create Pull Request

---

**Version**: 1.0.0+1  
**Last Updated**: 2024
