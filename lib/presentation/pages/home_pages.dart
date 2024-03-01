import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/bloc/notes_bloc/note_app_bloc.dart';
import 'package:notes_app/data/models/note_model.dart';
import 'package:notes_app/presentation/component/widgets/item_card.dart';
import 'package:notes_app/presentation/pages/add_page.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:notes_app/presentation/pages/favorite_page.dart';

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
            return AppBarOnEditListener(
              builder: (context, value, child) {
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
                    return itemCard(context, data: filteredData[index]);
                  },
                );
              },
            );
          }
          return const Center(
            child: Text("No Data"),
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(15),
        child: SpeedDial(
          spaceBetweenChildren: 12,
          childrenButtonSize: const Size(50, 50),
          animatedIcon: AnimatedIcons.menu_close,
          childMargin: const EdgeInsets.all(10),
          children: [
            SpeedDialChild(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.add),
              ),
              elevation: 7,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              label: "Add Note",
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddNotePage(),
                  )),
            ),
            SpeedDialChild(
              child: const Icon(
                Icons.bookmark,
              ),
              elevation: 7,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              label: "Favorite notes",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritePage(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
