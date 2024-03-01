import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/bloc/notes_bloc/note_app_bloc.dart';
import 'package:notes_app/data/models/note_model.dart';
import 'package:notes_app/presentation/component/function/global_function.dart';
import 'package:notes_app/presentation/pages/edit_page.dart';

Widget itemCard(BuildContext context, {required NoteModel data}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditNotePage(note: data),
        ),
      ),
      onLongPress: () => showModalBottomSheet(
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
                          id: data.id,
                        ),
                      );
                  context.read<NoteAppBloc>().add(NoteAppUpdateEvent());
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.delete),
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
      child: Stack(
        children: [
          Card(
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
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SizedBox(
                      width: 85,
                      height: 20,
                      child: Text(
                        data.title,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const Divider(),
                  Container(
                    height: 85,
                    width: double.infinity,
                    alignment: Alignment.topLeft,
                    child: Text(
                      data.content,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "${formatTime(data.createAt)}\n ${formatDate(data.createAt)}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: IconButton(
              onPressed: () {
                context.read<NoteAppBloc>().add(
                      NoteAppFavoriteEvent(
                        id: data.id,
                        title: data.title,
                        content: data.content,
                        createAt: data.createAt,
                        isFavorite: !data.isFavorite,
                      ),
                    );
                context.read<NoteAppBloc>().add(NoteAppUpdateEvent());
              },
              icon: Icon(
                Icons.bookmark,
                size: 32,
                color: data.isFavorite ? Colors.orange : Colors.grey,
              ),
            ),
          )
        ],
      ),
    ),
  );
}
