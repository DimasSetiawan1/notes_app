import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/bloc/notes_bloc/note_app_bloc.dart';
import 'package:notes_app/data/models/note_model.dart';
import 'package:notes_app/presentation/component/widgets/item_card.dart';
import 'package:notes_app/presentation/pages/add_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<NoteAppBloc>().add(NoteAppUpdateEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithSearchSwitch(
        appBarBuilder: (context) => AppBar(
          title: const Text("Note App"),
          actions: const [
            AppBarSearchButton(),
          ],
        ),
      ),
      body: BlocBuilder<NoteAppBloc, NoteAppState>(
        builder: (context, state) {
          if (state is NoteAppStateUpdate) {
            final data = state.noteList;
            final width = MediaQuery.of(context).size.width / 2;
            return AppBarOnEditListener(builder: (context, value, child) {
              List<NoteModel> filteredData = [];
              for (int i = 0; i < data.length; i++) {
                if (data[i]
                        .title
                        .toString()
                        .toLowerCase()
                        .replaceAll(" ", "")
                        .contains(value
                            .toString()
                            .toLowerCase()
                            .replaceAll(" ", "")) ||
                    data[i]
                        .content
                        .toString()
                        .toLowerCase()
                        .replaceAll(" ", "")
                        .contains(value
                            .toString()
                            .toLowerCase()
                            .replaceAll(" ", ""))) {
                  filteredData.add(data[i]);
                }
              }
              return GridView.builder(
                itemCount: filteredData.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: width / 200,
                ),
                itemBuilder: (context, index) {
                  return itemCard(context, data: filteredData, index: index);
                },
              );
            });
          }
          return const Center(
            child: Text("No Data"),
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(15),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddNotePage(),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
