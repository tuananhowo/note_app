import 'package:flutter/material.dart';
import '../viewmodels/notes_viewmodel.dart';
import '../models/note.dart';
import '../models/tag.dart';

/// Widget để chỉnh sửa và tạo mới notes
class NotesEditor extends StatefulWidget {
  final NotesViewModel viewModel;
  final bool isCreating;

  const NotesEditor({
    super.key,
    required this.viewModel,
    required this.isCreating,
  });

  @override
  State<NotesEditor> createState() => _NotesEditorState();
}

class _NotesEditorState extends State<NotesEditor> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  List<Tag> _selectedTags = [];

  @override
  void initState() {
    super.initState();
    _initializeForm();
  }

  @override
  void didUpdateWidget(NotesEditor oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Luôn reinitialize form khi có thay đổi
    _initializeForm();
  }

  void _initializeForm() {
    print('_initializeForm called - isCreating: ${widget.isCreating}');
    if (widget.isCreating) {
      print('Clearing form for new note');
      _titleController.clear();
      _contentController.clear();
      _selectedTags.clear();
    } else if (widget.viewModel.selectedNote != null) {
      final note = widget.viewModel.selectedNote!;
      print('Loading note: ${note.title}');
      _titleController.text = note.title;
      _contentController.text = note.content;
      _selectedTags = List.from(note.tags);
    }
  }

  void _resetForm() {
    _titleController.clear();
    _contentController.clear();
    _selectedTags.clear();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          Expanded(
            child: _buildEditor(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Text(
            widget.isCreating ? 'Ghi chú mới' : 'Chỉnh sửa ghi chú',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (!widget.isCreating) ...[
          IconButton(
            onPressed: _deleteNote,
            icon: const Icon(Icons.delete),
            style: IconButton.styleFrom(
              backgroundColor: Colors.red[50],
              foregroundColor: Colors.red[600],
            ),
          ),
          const SizedBox(width: 8),
        ],
        ElevatedButton.icon(
          onPressed: _saveNote,
          icon: const Icon(Icons.save),
          label: Text(widget.isCreating ? 'Tạo' : 'Lưu'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[600],
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEditor() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitleField(),
            const SizedBox(height: 20),
            _buildTagsSection(),
            const SizedBox(height: 20),
            _buildContentField(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleField() {
    return TextField(
      controller: _titleController,
      decoration: InputDecoration(
        labelText: 'Tiêu đề',
        hintText: 'Nhập tiêu đề ghi chú...',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.blue[600]!, width: 2),
        ),
      ),
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildTagsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tags:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: widget.viewModel.availableTags.map((tag) {
            final isSelected = _selectedTags.any((t) => t.id == tag.id);
            return FilterChip(
              label: Text(tag.name),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedTags.add(tag);
                  } else {
                    _selectedTags.removeWhere((t) => t.id == tag.id);
                  }
                });
              },
              selectedColor: tag.color.withOpacity(0.2),
              checkmarkColor: tag.color,
              side: BorderSide(
                color: isSelected ? tag.color : Colors.grey[300]!,
                width: isSelected ? 2 : 1,
              ),
              labelStyle: TextStyle(
                color: isSelected ? tag.color : Colors.grey[600],
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildContentField() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nội dung:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: TextField(
              controller: _contentController,
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                hintText: 'Nhập nội dung ghi chú...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.blue[600]!, width: 2),
                ),
                contentPadding: const EdgeInsets.all(12),
              ),
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveNote() async {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty) {
      _showErrorSnackBar('Vui lòng nhập tiêu đề');
      return;
    }

    try {
      if (widget.isCreating) {
        await widget.viewModel.createNote(
          title: title,
          content: content,
          tags: _selectedTags,
        );
        _showSuccessSnackBar('Đã tạo ghi chú mới');
      } else {
        await widget.viewModel.updateNote(
          id: widget.viewModel.selectedNote!.id,
          title: title,
          content: content,
          tags: _selectedTags,
        );
        _showSuccessSnackBar('Đã cập nhật ghi chú');
      }
    } catch (e) {
      _showErrorSnackBar('Lỗi: $e');
    }
  }

  Future<void> _deleteNote() async {
    if (widget.viewModel.selectedNote == null) return;

    final confirmed = await _showDeleteConfirmation();
    if (confirmed) {
      try {
        await widget.viewModel.deleteNote(widget.viewModel.selectedNote!.id);
        _showSuccessSnackBar('Đã xóa ghi chú');
      } catch (e) {
        _showErrorSnackBar('Lỗi: $e');
      }
    }
  }

  Future<bool> _showDeleteConfirmation() async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Xác nhận xóa'),
            content: const Text('Bạn có chắc chắn muốn xóa ghi chú này?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Hủy'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Xóa'),
              ),
            ],
          ),
        ) ??
        false;
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
