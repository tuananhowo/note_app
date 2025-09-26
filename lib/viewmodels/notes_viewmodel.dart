import 'package:flutter/material.dart';
import '../models/note.dart';
import '../models/tag.dart';
import '../models/app_state.dart';
import '../services/notes_service.dart';

/// ViewModel cho quản lý state và business logic của Notes
class NotesViewModel extends ChangeNotifier {
  final NotesService _notesService;

  AppState _state = const AppState();

  NotesViewModel(this._notesService) {
    _initialize();
  }

  /// Getter cho state hiện tại
  AppState get state => _state;

  /// Getter cho các thuộc tính thường dùng
  List<Note> get notes => _state.notes;
  List<Tag> get availableTags => _state.availableTags;
  Note? get selectedNote => _state.selectedNote;
  bool get isCreatingNew => _state.isCreatingNew;
  bool get isLoading => _state.isLoading;
  String? get error => _state.error;

  /// Khởi tạo dữ liệu ban đầu
  Future<void> _initialize() async {
    await loadNotes();
    _loadAvailableTags();
  }

  /// Tải danh sách notes
  Future<void> loadNotes() async {
    _setLoading(true);
    try {
      final notes = await _notesService.getAllNotes();
      _updateState(_state.copyWith(notes: notes));
    } catch (e) {
      _setError('Không thể tải danh sách ghi chú: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Tải danh sách tags có sẵn
  void _loadAvailableTags() {
    final tags = _notesService.getAvailableTags();
    _updateState(_state.copyWith(availableTags: tags));
  }

  /// Bắt đầu tạo note mới
  void startCreatingNew() {
    _updateState(_state.startCreatingNew());
  }

  /// Chọn note
  void selectNote(Note note) {
    _updateState(_state.selectNote(note));
  }

  /// Tạo note mới
  Future<void> createNote({
    required String title,
    required String content,
    List<Tag> tags = const [],
  }) async {
    _setLoading(true);
    try {
      final newNote = await _notesService.createNote(
        title: title,
        content: content,
        tags: tags,
      );
      _updateState(_state.addNote(newNote));
    } catch (e) {
      _setError('Không thể tạo ghi chú: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Cập nhật note
  Future<void> updateNote({
    required String id,
    required String title,
    required String content,
    List<Tag> tags = const [],
  }) async {
    _setLoading(true);
    try {
      final updatedNote = await _notesService.updateNote(
        id: id,
        title: title,
        content: content,
        tags: tags,
      );
      _updateState(_state.updateNote(updatedNote));
    } catch (e) {
      _setError('Không thể cập nhật ghi chú: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Xóa note
  Future<void> deleteNote(String id) async {
    _setLoading(true);
    try {
      await _notesService.deleteNote(id);
      _updateState(_state.removeNote(id));
    } catch (e) {
      _setError('Không thể xóa ghi chú: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Tìm kiếm notes
  Future<void> searchNotes(String query) async {
    _setLoading(true);
    try {
      final searchResults = await _notesService.searchNotes(query);
      _updateState(_state.copyWith(notes: searchResults));
    } catch (e) {
      _setError('Không thể tìm kiếm ghi chú: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Lọc notes theo tag
  Future<void> filterNotesByTag(String tagId) async {
    _setLoading(true);
    try {
      final filteredNotes = await _notesService.getNotesByTag(tagId);
      _updateState(_state.copyWith(notes: filteredNotes));
    } catch (e) {
      _setError('Không thể lọc ghi chú: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Xóa bộ lọc và tải lại tất cả notes
  Future<void> clearFilter() async {
    await loadNotes();
  }

  /// Xóa error
  void clearError() {
    _updateState(_state.clearError());
  }

  /// Cập nhật state
  void _updateState(AppState newState) {
    _state = newState;
    notifyListeners();
  }

  /// Set loading state
  void _setLoading(bool loading) {
    _updateState(_state.copyWith(isLoading: loading));
  }

  /// Set error
  void _setError(String error) {
    _updateState(_state.copyWith(error: error, isLoading: false));
  }

  /// Lấy note theo ID
  Note? getNoteById(String id) {
    try {
      return notes.firstWhere((note) => note.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Kiểm tra xem có đang tạo note mới không
  bool get isCreatingNote => isCreatingNew && selectedNote == null;

  /// Kiểm tra xem có đang chỉnh sửa note không
  bool get isEditingNote => selectedNote != null && !isCreatingNew;

  /// Lấy số lượng notes
  int get notesCount => notes.length;

  /// Lấy số lượng tags
  int get tagsCount => availableTags.length;

  /// Kiểm tra xem có lỗi không
  bool get hasError => error != null;

  /// Kiểm tra xem có notes không
  bool get hasNotes => notes.isNotEmpty;

  /// Kiểm tra xem có đang loading không
  bool get isBusy => isLoading;

  @override
  void dispose() {
    super.dispose();
  }
}
