import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:notes_app/data/database/db_manager.dart';
import 'package:notes_app/data/models/note_model.dart';
import 'package:sqflite/sqflite.dart';

part 'note_app_event.dart';
part 'note_app_state.dart';

class NoteAppBloc extends Bloc<NoteAppEvent, NoteAppState> {
  final DatabaseManager _dbManager;
  NoteAppBloc(this._dbManager) : super(NoteAppStateInitial()) {
    on<NoteAppAddEvent>(_addNoteList);
    on<NoteAppUpdateEvent>(_updateNoteList);
    on<NoteAppEditEvent>(_editNoteList);
    on<NoteAppDeleteEvent>(_deleteNoteList);
  }
  Future _editNoteList(
      NoteAppEditEvent event, Emitter<NoteAppState> emit) async {
    Database db = await _dbManager.database;
    await db.update(
      'Notes',
      {
        'id': event.id,
        'title': event.title,
        'content': event.content,
        'createAt': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [event.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await db.close();
  }

  Future _addNoteList(NoteAppAddEvent event, Emitter<NoteAppState> emit) async {
    Database db = await _dbManager.database;
    final data = event.notes;
    await db.insert(
      'Notes',
      data.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await db.close();
  }

  Future _updateNoteList(
      NoteAppUpdateEvent event, Emitter<NoteAppState> emit) async {
    Database db = await _dbManager.database;
    List<Map<String, dynamic>> result = await db.query("Notes");
    if (result.isNotEmpty) {
      emit(
        NoteAppStateUpdate(
          noteList: result
              .map(
                (e) => NoteModel.fromJson(e),
              )
              .toList(),
        ),
      );
    }
    await db.close();
  }

  Future _deleteNoteList(
      NoteAppDeleteEvent event, Emitter<NoteAppState> emit) async {
    Database db = await _dbManager.database;
    await db.delete('Notes', where: 'id = ?', whereArgs: [event.id]);
    await db.close();
  }
}
