import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controllers/note_controller.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/widgets/widget_base.dart';

class DetailPage extends GetView<MainController> {
  final NoteModel noteModel;
  const DetailPage(this.noteModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Detail Note Page'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 48),
              MyNoteCard(noteModel: noteModel.title),
              const SizedBox(height: 48),
              MyNoteCard(noteModel: noteModel.description),
              const SizedBox(height: 48),
              MyNoteCard(noteModel: noteModel.date),
            ],
          ),
        ),
      ),
    );
  }
}
