import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controllers/note_controller.dart';
import 'package:note_app/widgets/widget_base.dart';

class HomePage extends GetView<MainController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Main Note Page'),
        actions: const [
          NewItemNote(),
          DeleteSelectItem(),
          DeleteAllNote(),
        ],
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: controller.noteList.length,
          itemBuilder: (context, index) {
            final dataNote = controller.noteList[index];
            return ItemNote(dataNote: dataNote, index: index);
          },
        );
      }),
    );
  }
}
