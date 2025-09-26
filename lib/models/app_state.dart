import 'note.dart';
import 'tag.dart';

/// Trạng thái tổng thể của ứng dụng
class AppState {
  final List<Note> notes;
  final List<Tag> availableTags;
  final Note? selectedNote;
  final bool isCreatingNew;
  final bool isLoading;
  final String? error;

  const AppState({
    this.notes = const [],
    this.availableTags = const [],
    this.selectedNote,
    this.isCreatingNew = false,
    this.isLoading = false,
    this.error,
  });

  /// Tạo bản sao của AppState với các thuộc tính có thể thay đổi
  AppState copyWith({
    List<Note>? notes,
    List<Tag>? availableTags,
    Note? selectedNote,
    bool? isCreatingNew,
    bool? isLoading,
    String? error,
  }) {
    return AppState(
      notes: notes ?? this.notes,
      availableTags: availableTags ?? this.availableTags,
      selectedNote: selectedNote ?? this.selectedNote,
      isCreatingNew: isCreatingNew ?? this.isCreatingNew,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  /// Xóa error khỏi state
  AppState clearError() {
    return copyWith(error: null);
  }

  /// Bắt đầu tạo note mới
  AppState startCreatingNew() {
    return copyWith(
      isCreatingNew: true,
      selectedNote: null,
    );
  }

  /// Chọn note
  AppState selectNote(Note note) {
    return copyWith(
      selectedNote: note,
      isCreatingNew: false,
    );
  }

  /// Thêm note mới
  AppState addNote(Note note) {
    return copyWith(
      notes: [...notes, note],
      selectedNote: note,
      isCreatingNew: false,
    );
  }

  /// Cập nhật note
  AppState updateNote(Note updatedNote) {
    final updatedNotes = notes.map((note) {
      return note.id == updatedNote.id ? updatedNote : note;
    }).toList();

    return copyWith(
      notes: updatedNotes,
      selectedNote: updatedNote,
    );
  }

  /// Xóa note
  AppState removeNote(String noteId) {
    final updatedNotes = notes.where((note) => note.id != noteId).toList();
    final newSelectedNote = selectedNote?.id == noteId ? null : selectedNote;

    return copyWith(
      notes: updatedNotes,
      selectedNote: newSelectedNote,
    );
  }

  /// Lấy notes theo tag
  List<Note> getNotesByTag(String tagId) {
    return notes.where((note) => note.hasTag(tagId)).toList();
  }

  /// Tìm kiếm notes theo từ khóa
  List<Note> searchNotes(String query) {
    if (query.trim().isEmpty) return notes;

    final lowercaseQuery = query.toLowerCase();
    return notes.where((note) {
      return note.title.toLowerCase().contains(lowercaseQuery) ||
          note.content.toLowerCase().contains(lowercaseQuery) ||
          note.tagNames
              .any((tagName) => tagName.toLowerCase().contains(lowercaseQuery));
    }).toList();
  }

  @override
  String toString() {
    return 'AppState(notes: ${notes.length}, selectedNote: $selectedNote, isCreatingNew: $isCreatingNew, isLoading: $isLoading, error: $error)';
  }
}
