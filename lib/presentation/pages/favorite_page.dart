import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/bloc/notes_bloc/note_app_bloc.dart';
import 'package:notes_app/data/models/note_model.dart';
import 'package:notes_app/presentation/component/widgets/item_card.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    context.read<NoteAppBloc>().add(NoteAppUpdateEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Page"),
      ),
      body: BlocBuilder<NoteAppBloc, NoteAppState>(
        builder: (context, state) {
          if (state is NoteAppStateUpdate) {
            final data = state.noteList;
            final width = MediaQuery.of(context).size.width / 2;
            final List<NoteModel> dataFavorite = [];
            for (int i = 0; i < data.length; i++) {
              if (data[i].isFavorite) {
                dataFavorite.add(data[i]);
              }
            }
            return GridView.builder(
              itemCount: dataFavorite.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: width / 200,
              ),
              itemBuilder: (context, index) {
                return itemCard(context, data: dataFavorite[index]);
              },
            );
          } else {
            return const Center(
              child: Text("No Favorite notes"),
            );
          }
        },
      ),
    );
  }
}
