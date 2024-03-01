// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NoteModelImpl _$$NoteModelImplFromJson(Map<String, dynamic> json) =>
    _$NoteModelImpl(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      createAt: DateTime.parse(json['createAt'] as String),
      isFavorite: json['isFavorite'] as bool? ?? false,
    );

Map<String, dynamic> _$$NoteModelImplToJson(_$NoteModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'createAt': instance.createAt.toIso8601String(),
      'isFavorite': instance.isFavorite,
    };
