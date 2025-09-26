import 'package:flutter/material.dart';
import 'repositories/notes_repository.dart';
import 'services/notes_service.dart';
import 'viewmodels/notes_viewmodel.dart';
import 'views/notes_home_page.dart';
import 'utils/constants.dart';

void main() {
  runApp(const NotesApp());
}

/// Ứng dụng chính
class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: _buildTheme(),
      home: const NotesAppProvider(),
      debugShowCheckedModeBanner: false,
    );
  }

  /// Tạo theme cho ứng dụng
  ThemeData _buildTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppConstants.primaryColor,
        brightness: Brightness.light,
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          borderSide: const BorderSide(
            color: AppConstants.primaryColor,
            width: 2,
          ),
        ),
      ),
    );
  }
}

/// Provider widget để inject dependencies
class NotesAppProvider extends StatelessWidget {
  const NotesAppProvider({super.key});

  @override
  Widget build(BuildContext context) {
    // Dependency Injection
    final repository = InMemoryNotesRepository();
    final service = NotesService(repository);
    final viewModel = NotesViewModel(service);

    return NotesHomePage(viewModel: viewModel);
  }
}
