import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/bloc/notes_bloc/note_app_bloc.dart';
import 'package:notes_app/data/models/note_model.dart';
import 'package:notes_app/presentation/component/widgets/note_textfield.dart';

class EditNotePage extends StatelessWidget {
  EditNotePage({
    super.key,
    required this.note,
  });

  final NoteModel note;

  late final TextEditingController _controllerContent =
      TextEditingController(text: note.content);
  late final TextEditingController _controllerTitle =
      TextEditingController(text: note.title);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Note"),
          actions: [
            IconButton(
              onPressed: () {
                context.read<NoteAppBloc>().add(
                      NoteAppEditEvent(
                        id: note.id,
                        title: _controllerTitle.text,
                        content: _controllerContent.text,
                        isFavorite: note.isFavorite,
                      ),
                    );
                context.read<NoteAppBloc>().add(NoteAppUpdateEvent());
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(
                      "Success Edit Note",
                      style: TextStyle(color: Colors.white70),
                    ),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.blueGrey[200]!.withOpacity(0.2),
                    duration: const Duration(seconds: 1),
                    margin: const EdgeInsets.all(15),
                    padding: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.check_outlined),
            ),
            const SizedBox(width: 15)
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            NoteWidget(
              controllerTitle: _controllerTitle,
              controllerContent: _controllerContent,
            ),
          ],
        ));
  }
}
