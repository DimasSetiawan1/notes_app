import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/bloc/notes_bloc/note_app_bloc.dart';
import 'package:notes_app/data/models/note_model.dart';
import 'package:notes_app/presentation/component/widgets/note_textfield.dart';

class AddNotePage extends StatelessWidget {
  AddNotePage({super.key});

  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerContent = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Note"),
        actions: [
          const SizedBox(width: 15),
          IconButton(
              onPressed: () {
                if (_controllerTitle.text.isNotEmpty &&
                    _controllerContent.text.isNotEmpty) {
                  context.read<NoteAppBloc>().add(
                        NoteAppAddEvent(
                          notes: NoteModel(
                            id: Random().nextInt(100),
                            title: _controllerTitle.text,
                            content: _controllerContent.text,
                            createAt: DateTime.now(),
                          ),
                        ),
                      );
                  context.read<NoteAppBloc>().add(NoteAppUpdateEvent());

                  _controllerTitle.text = "";
                  _controllerContent.text = "";
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        "Success Add Note",
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
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Error"),
                      content: const Text("Title and Content cannot be empty"),
                      actions: [
                        TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            backgroundColor:
                                const Color.fromARGB(255, 114, 9, 146),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("OK"),
                        )
                      ],
                    ),
                  );
                }
              },
              icon: const Icon(Icons.check_outlined))
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          NoteWidget(
            controllerTitle: _controllerTitle,
            controllerContent: _controllerContent,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
