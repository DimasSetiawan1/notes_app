import 'package:flutter/material.dart';

class NoteWidget extends StatelessWidget {
  const NoteWidget({
    super.key,
    required this.controllerTitle,
    required this.controllerContent,
  });
  final TextEditingController controllerTitle;
  final TextEditingController controllerContent;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(15),
      children: [
        TextField(
          controller: controllerTitle,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Title",
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextField(
          controller: controllerContent,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Description",
          ),
          maxLines: 100,
          minLines: 10,
        )
      ],
    );
  }
}
