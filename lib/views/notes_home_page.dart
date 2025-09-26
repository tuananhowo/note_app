import 'package:flutter/material.dart';
import '../viewmodels/notes_viewmodel.dart';
import '../widgets/notes_sidebar.dart';
import '../widgets/notes_editor.dart';
import '../widgets/empty_state.dart';

/// Trang chính của ứng dụng Notes
class NotesHomePage extends StatefulWidget {
  final NotesViewModel viewModel;

  const NotesHomePage({
    super.key,
    required this.viewModel,
  });

  @override
  State<NotesHomePage> createState() => _NotesHomePageState();
}

class _NotesHomePageState extends State<NotesHomePage> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.addListener(_onViewModelChanged);
  }

  @override
  void dispose() {
    widget.viewModel.removeListener(_onViewModelChanged);
    super.dispose();
  }

  void _onViewModelChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Row(
        children: [
          // Sidebar
          NotesSidebar(viewModel: widget.viewModel),

          // Main Content
          Expanded(
            child: _buildMainContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    if (widget.viewModel.isCreatingNew) {
      return NotesEditor(
        viewModel: widget.viewModel,
        isCreating: true,
      );
    }

    if (widget.viewModel.selectedNote != null) {
      return NotesEditor(
        viewModel: widget.viewModel,
        isCreating: false,
      );
    }

    return const EmptyState();
  }
}
