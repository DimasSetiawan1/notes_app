part of 'note_app_bloc.dart';

@immutable
sealed class NoteAppEvent {}

final class NoteAppInitialEvent extends NoteAppEvent {}

final class NoteAppAddEvent extends NoteAppEvent {
  final NoteModel notes;
  NoteAppAddEvent({required this.notes});
}

final class NoteAppUpdateEvent extends NoteAppEvent {}

final class NoteAppFavoriteEvent extends NoteAppEvent {
  final int id;
  final String title;
  final String content;
  final DateTime createAt;
  final bool isFavorite;
  NoteAppFavoriteEvent({
    required this.id,
    required this.title,
    required this.content,
    required this.createAt,
    required this.isFavorite,
  });
}

final class NoteAppEditEvent extends NoteAppEvent {
  final int id;
  final String title;
  final String content;
  final bool isFavorite;
  NoteAppEditEvent({
    required this.id,
    required this.title,
    required this.content,
    required this.isFavorite,
  });
}

final class NoteAppDeleteEvent extends NoteAppEvent {
  final int id;
  NoteAppDeleteEvent({required this.id});
}
