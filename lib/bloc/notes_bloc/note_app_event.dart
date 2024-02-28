part of 'note_app_bloc.dart';

@immutable
sealed class NoteAppEvent {}

final class NoteAppInitialEvent extends NoteAppEvent {}

final class NoteAppAddEvent extends NoteAppEvent {
  final NoteModel notes;
  NoteAppAddEvent({required this.notes});
}

final class NoteAppUpdateEvent extends NoteAppEvent {}

final class NoteAppEditEvent extends NoteAppEvent {
  final int id;
  final String title;
  final String content;
  NoteAppEditEvent({required this.id, required this.title, required this.content});
}

final class NoteAppDeleteEvent extends NoteAppEvent {
 final int id;
  NoteAppDeleteEvent({required this.id});
}
