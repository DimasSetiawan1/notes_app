part of 'note_app_bloc.dart';

@immutable
sealed class NoteAppState {}

final class NoteAppStateInitial extends NoteAppState {

}

final class NoteAppStateAdd extends NoteAppState {
  final List<NoteModel> noteList;
  NoteAppStateAdd({required this.noteList});
}

final class NoteAppStateFavorite extends NoteAppState {
  final bool isFavorite;
  NoteAppStateFavorite({required this.isFavorite});
}

final class NoteAppStateUpdate extends NoteAppState {
  final List<NoteModel> noteList;
  NoteAppStateUpdate({required this.noteList});
}

final class NoteAppStateEdit extends NoteAppState {}
final class NoteAppStateDelete extends NoteAppState {}
