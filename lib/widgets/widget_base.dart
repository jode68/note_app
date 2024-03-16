import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:note_app/controllers/note_controller.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/views/detail_page.dart';

class ItemNote extends GetView<MainController> {
  const ItemNote({
    required this.dataNote,
    required this.index,
    super.key,
  });

  final NoteModel dataNote;
  final int index;

  @override
  Widget build(BuildContext context) {
    TextStyle textLine = TextStyle(
      decoration: dataNote.isComplete ? TextDecoration.lineThrough : TextDecoration.none,
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (BuildContext context) {
                if (dataNote.isComplete) {
                  deleteItemNote(index);
                }
              },
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(8),
            ),
            SlidableAction(
              onPressed: (BuildContext context) {
                editItemNote(dataNote, index);
              },
              icon: Icons.edit,
              backgroundColor: Colors.green,
              borderRadius: BorderRadius.circular(8),
            )
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            onTap: () {
              Get.to(() => DetailPage(dataNote));
            },
            title: Text(dataNote.title, style: textLine),
            subtitle: Text(dataNote.description, style: textLine, maxLines: 1),
            trailing: Text(dataNote.date, style: textLine),
            leading: Switch(
              inactiveThumbColor: Colors.blue,
              inactiveTrackColor: Colors.blue.shade300,
              activeColor: Colors.red,
              value: dataNote.isComplete,
              onChanged: (value) {
                if (value) {
                  dataNote.isComplete = value;
                  controller.editItem(dataNote, index);
                  controller.updateDataFunc();
                } else {
                  dataNote.isComplete = value;
                  controller.editItem(dataNote, index);
                  controller.updateDataFunc();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class NewItemNote extends GetView<MainController> {
  const NewItemNote({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Get.bottomSheet(
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Add new Note',
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 32),
                  TextField(
                    controller: controller.title,
                    autofocus: true,
                    autocorrect: false,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 32),
                  TextField(
                    controller: controller.description,
                    autocorrect: false,
                    onSubmitted: (value) {
                      controller.addDataFunc();
                    },
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      controller.addDataFunc();
                    },
                    child: const Text('Save'),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
          backgroundColor: Colors.white,
        );
        controller.title.clear();
        controller.description.clear();
      },
      icon: const Icon(Icons.add_circle),
    );
  }
}

void editItemNote(NoteModel dataNote, int index) {
  final controller = Get.put(MainController());
  controller.title.text = dataNote.title;
  controller.description.text = dataNote.description;
  Get.bottomSheet(
    SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Add new Note',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 32),
            TextField(
              controller: controller.title,
              autofocus: true,
              autocorrect: false,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 32),
            TextField(
              controller: controller.description,
              autocorrect: false,
              onSubmitted: (value) {
                controller.editDataFunc(index);
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                controller.editDataFunc(index);
              },
              child: const Text('UpDate'),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    ),
    backgroundColor: Colors.white,
  );
}

void deleteItemNote(int index) {
  final controller = Get.put(MainController());
  Get.defaultDialog(
    title: 'Delete Note',
    middleText: 'Confirm clear Note ?',
    titleStyle: TextStyle(color: controller.textColor),
    middleTextStyle: TextStyle(color: controller.textColor),
    confirmTextColor: controller.buttonColor,
    buttonColor: controller.buttonBackColor,
    backgroundColor: controller.prymaryColor,
    onConfirm: () {
      controller.deleteItemFunc(index);
      Get.back();
    },
  );
}

class DeleteSelectItem extends GetView<MainController> {
  const DeleteSelectItem({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        var exist = controller.noteList.where((element) => element.isComplete).isNotEmpty;
        if (exist) {
          Get.defaultDialog(
            title: 'Delete Select Note',
            middleText: 'Confirm clear Select Note ?',
            titleStyle: TextStyle(color: controller.textColor),
            middleTextStyle: TextStyle(color: controller.textColor),
            confirmTextColor: controller.buttonColor,
            buttonColor: controller.buttonBackColor,
            backgroundColor: controller.prymaryColor,
            onConfirm: () {
              controller.deleteSelectItemFunc();
              Get.back();
            },
          );
        }
      },
      icon: const Icon(Icons.playlist_remove_outlined),
    );
  }
}

class DeleteAllNote extends GetView<MainController> {
  const DeleteAllNote({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (controller.noteList.isNotEmpty) {
          Get.defaultDialog(
            title: 'Delete All Note',
            middleText: 'Confirm clear all Note ?',
            titleStyle: TextStyle(color: controller.textColor),
            middleTextStyle: TextStyle(color: controller.textColor),
            confirmTextColor: controller.buttonColor,
            buttonColor: controller.buttonBackColor,
            backgroundColor: controller.prymaryColor,
            onConfirm: () {
              controller.deleteAllItemFunc();
              Get.back();
            },
          );
        }
      },
      icon: const Icon(Icons.delete_forever),
    );
  }
}

class MyNoteCard extends StatelessWidget {
  const MyNoteCard({
    super.key,
    required this.noteModel,
  });

  final String noteModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightGreen,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          noteModel,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
