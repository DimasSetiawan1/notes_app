import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/bloc/notes_bloc/note_app_bloc.dart';
import 'package:notes_app/data/models/note_model.dart';
import 'package:notes_app/presentation/component/function/global_function.dart';
import 'package:notes_app/presentation/pages/edit_page.dart';

Widget itemCard(BuildContext context,
    {required List<NoteModel> data, required int index}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: GestureDetector(
      onTap: () => showModalBottomSheet(
        context: context,
        useSafeArea: true,
        clipBehavior: Clip.hardEdge,
        builder: (context) => SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  context.read<NoteAppBloc>().add(
                        NoteAppDeleteEvent(
                          id: data[index].id,
                        ),
                      );
                  context.read<NoteAppBloc>().add(NoteAppUpdateEvent());
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.delete),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EditNotePage(note: data[index]),
                    ),
                  );
                },
                icon: const Icon(Icons.edit),
              ),
            ],
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
      ),
      child: Card(
        elevation: 7,
        shadowColor: Color.fromRGBO(Random().nextInt(255),
            Random().nextInt(255), Random().nextInt(255), 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(data[index].title),
              const Divider(),
              Container(
                height: 85,
                width: double.infinity,
                alignment: Alignment.topLeft,
                child: Text(
                  data[index].content,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Expanded(
                child: Text(
                  "${formatTime(data[index].createAt)}\n ${formatDate(data[index].createAt)}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
