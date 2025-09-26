import 'package:flutter/material.dart';
import '../models/note.dart';
import '../models/tag.dart';
import '../repositories/notes_repository.dart';

/// Service layer cho việc quản lý business logic của notes
class NotesService {
  final NotesRepository _repository;

  NotesService(this._repository);

  /// Lấy tất cả notes
  Future<List<Note>> getAllNotes() async {
    try {
      return await _repository.getAllNotes();
    } catch (e) {
      throw NotesServiceException('Không thể tải danh sách ghi chú: $e');
    }
  }

  /// Lấy note theo ID
  Future<Note?> getNoteById(String id) async {
    try {
      if (id.isEmpty) {
        throw NotesServiceException('ID ghi chú không hợp lệ');
      }
      return await _repository.getNoteById(id);
    } catch (e) {
      throw NotesServiceException('Không thể tải ghi chú: $e');
    }
  }

  /// Tạo note mới
  Future<Note> createNote({
    required String title,
    required String content,
    List<Tag> tags = const [],
  }) async {
    try {
      // Validation
      if (title.trim().isEmpty) {
        throw NotesServiceException('Tiêu đề không được để trống');
      }

      if (title.trim().length > 200) {
        throw NotesServiceException('Tiêu đề không được vượt quá 200 ký tự');
      }

      if (content.trim().length > 10000) {
        throw NotesServiceException('Nội dung không được vượt quá 10000 ký tự');
      }

      final note = Note(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title.trim(),
        content: content.trim(),
        tags: List.from(tags),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      return await _repository.saveNote(note);
    } catch (e) {
      if (e is NotesServiceException) rethrow;
      throw NotesServiceException('Không thể tạo ghi chú: $e');
    }
  }

  /// Cập nhật note
  Future<Note> updateNote({
    required String id,
    required String title,
    required String content,
    List<Tag> tags = const [],
  }) async {
    try {
      // Validation
      if (id.isEmpty) {
        throw NotesServiceException('ID ghi chú không hợp lệ');
      }

      if (title.trim().isEmpty) {
        throw NotesServiceException('Tiêu đề không được để trống');
      }

      if (title.trim().length > 200) {
        throw NotesServiceException('Tiêu đề không được vượt quá 200 ký tự');
      }

      if (content.trim().length > 10000) {
        throw NotesServiceException('Nội dung không được vượt quá 10000 ký tự');
      }

      // Kiểm tra note có tồn tại không
      final existingNote = await _repository.getNoteById(id);
      if (existingNote == null) {
        throw NotesServiceException('Ghi chú không tồn tại');
      }

      final updatedNote = existingNote.updateWith(
        title: title.trim(),
        content: content.trim(),
        tags: List.from(tags),
      );

      return await _repository.updateNote(updatedNote);
    } catch (e) {
      if (e is NotesServiceException) rethrow;
      throw NotesServiceException('Không thể cập nhật ghi chú: $e');
    }
  }

  /// Xóa note
  Future<void> deleteNote(String id) async {
    try {
      if (id.isEmpty) {
        throw NotesServiceException('ID ghi chú không hợp lệ');
      }

      // Kiểm tra note có tồn tại không
      final existingNote = await _repository.getNoteById(id);
      if (existingNote == null) {
        throw NotesServiceException('Ghi chú không tồn tại');
      }

      await _repository.deleteNote(id);
    } catch (e) {
      if (e is NotesServiceException) rethrow;
      throw NotesServiceException('Không thể xóa ghi chú: $e');
    }
  }

  /// Tìm kiếm notes
  Future<List<Note>> searchNotes(String query) async {
    try {
      return await _repository.searchNotes(query);
    } catch (e) {
      throw NotesServiceException('Không thể tìm kiếm ghi chú: $e');
    }
  }

  /// Lấy notes theo tag
  Future<List<Note>> getNotesByTag(String tagId) async {
    try {
      if (tagId.isEmpty) {
        throw NotesServiceException('ID tag không hợp lệ');
      }
      return await _repository.getNotesByTag(tagId);
    } catch (e) {
      throw NotesServiceException('Không thể lọc ghi chú theo tag: $e');
    }
  }

  /// Lấy danh sách tags có sẵn
  List<Tag> getAvailableTags() {
    if (_repository is InMemoryNotesRepository) {
      return (_repository as InMemoryNotesRepository).getAvailableTags();
    }
    return [];
  }

  /// Thêm tag mới
  void addTag(Tag tag) {
    if (_repository is InMemoryNotesRepository) {
      (_repository as InMemoryNotesRepository).addTag(tag);
    }
  }

  /// Xóa tag
  void removeTag(String tagId) {
    if (_repository is InMemoryNotesRepository) {
      (_repository as InMemoryNotesRepository).removeTag(tagId);
    }
  }
}

/// Exception cho NotesService
class NotesServiceException implements Exception {
  final String message;

  const NotesServiceException(this.message);

  @override
  String toString() => 'NotesServiceException: $message';
}
