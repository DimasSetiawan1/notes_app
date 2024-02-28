import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/bloc/notes_bloc/note_app_bloc.dart';
import 'package:notes_app/data/database/db_manager.dart';
import 'package:notes_app/presentation/pages/home_pages.dart';

void main() => runApp(const NotedApp());

class NotedApp extends StatelessWidget {
  const NotedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoteAppBloc(DatabaseManager.db),
      child: MaterialApp(
        home: const HomePage(),
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
      ),
    );
  }
}
