import 'package:flutter/material.dart';
import '../models/note.dart';
import '../models/tag.dart';

/// Abstract repository cho việc quản lý notes
abstract class NotesRepository {
  /// Lấy tất cả notes
  Future<List<Note>> getAllNotes();

  /// Lấy note theo ID
  Future<Note?> getNoteById(String id);

  /// Lưu note mới
  Future<Note> saveNote(Note note);

  /// Cập nhật note
  Future<Note> updateNote(Note note);

  /// Xóa note
  Future<void> deleteNote(String id);

  /// Tìm kiếm notes
  Future<List<Note>> searchNotes(String query);

  /// Lấy notes theo tag
  Future<List<Note>> getNotesByTag(String tagId);
}

/// In-memory repository implementation
class InMemoryNotesRepository implements NotesRepository {
  final List<Note> _notes = [];
  final List<Tag> _availableTags = [
    const Tag(id: '1', name: 'Công việc', color: Colors.red),
    const Tag(id: '2', name: 'Cá nhân', color: Colors.blue),
    const Tag(id: '3', name: 'Học tập', color: Colors.green),
    const Tag(id: '4', name: 'Quan trọng', color: Colors.orange),
    const Tag(id: '5', name: 'Ý tưởng', color: Colors.purple),
  ];

  @override
  Future<List<Note>> getAllNotes() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 100));
    return List.from(_notes);
  }

  @override
  Future<Note?> getNoteById(String id) async {
    await Future.delayed(const Duration(milliseconds: 50));
    try {
      return _notes.firstWhere((note) => note.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Note> saveNote(Note note) async {
    await Future.delayed(const Duration(milliseconds: 150));
    _notes.add(note);
    return note;
  }

  @override
  Future<Note> updateNote(Note note) async {
    await Future.delayed(const Duration(milliseconds: 150));
    final index = _notes.indexWhere((n) => n.id == note.id);
    if (index != -1) {
      _notes[index] = note;
    }
    return note;
  }

  @override
  Future<void> deleteNote(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _notes.removeWhere((note) => note.id == id);
  }

  @override
  Future<List<Note>> searchNotes(String query) async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (query.trim().isEmpty) return getAllNotes();

    final lowercaseQuery = query.toLowerCase();
    return _notes.where((note) {
      return note.title.toLowerCase().contains(lowercaseQuery) ||
          note.content.toLowerCase().contains(lowercaseQuery) ||
          note.tagNames
              .any((tagName) => tagName.toLowerCase().contains(lowercaseQuery));
    }).toList();
  }

  @override
  Future<List<Note>> getNotesByTag(String tagId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _notes.where((note) => note.hasTag(tagId)).toList();
  }

  /// Lấy danh sách tags có sẵn
  List<Tag> getAvailableTags() {
    return List.from(_availableTags);
  }

  /// Thêm tag mới
  void addTag(Tag tag) {
    _availableTags.add(tag);
  }

  /// Xóa tag
  void removeTag(String tagId) {
    _availableTags.removeWhere((tag) => tag.id == tagId);
  }
}
