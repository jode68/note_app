import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:note_app/models/note_model.dart';

class NoteController extends GetxController {
  // List Note OBS
  final noteList = <NoteModel>[].obs;

  // Set Date Today
  final dateToday = DateFormat('dd-MM-yyyy').format(DateTime.now());
}

class CommandController extends NoteController {
  // Add Item to List
  void addItem(NoteModel noteModel) {
    noteList.add(noteModel);
    noteList.refresh();
  }

  // Edit Item in List
  void editItem(NoteModel noteModel, int index) {
    noteList[index] = noteModel;
    noteList.refresh();
  }

  // Delete Item in List
  void deleteItem(int index) {
    noteList.removeAt(index);
    noteList.refresh();
  }

  // Clear all List
  void clearAllList() {
    noteList.clear();
    noteList.refresh();
  }
}

class DataBaseNote extends CommandController {
  // Set SetStorage and defaul Name DB
  final storageNote = GetStorage();
  final storageName = 'NoteList';

  void initStorageNote() async {
    await GetStorage.init();
    loadStorageNote();
  }

  void saveStorageNote() async {
    await storageNote.write(storageName, noteList.toJson());
  }

  void loadStorageNote() async {
    if (storageNote.hasData(storageName)) {
      var data = storageNote.read(storageName) as List;
      noteList.value = data.map((e) => NoteModel.fromJson(e)).toList();
    } else {
      noteList.clear();
    }
  }

  void clearStorageNote() async {
    await storageNote.remove(storageName);
    await storageNote.erase();
  }
}

class InputDataNote extends DataBaseNote {
  final title = TextEditingController();
  final description = TextEditingController();
  bool isComplete = false;

  void addDataFunc() {
    if (title.text.isNotEmpty && description.text.isNotEmpty) {
      final data = NoteModel(title.text, description.text, dateToday, isComplete);
      addItem(data);
      saveStorageNote();
      Get.back();
    }
  }

  void editDataFunc(int index) {
    final data = NoteModel(title.text, description.text, dateToday, isComplete);
    editItem(data, index);
    saveStorageNote();
    Get.back();
  }

  void updateDataFunc() {
    saveStorageNote();
  }

  void deleteItemFunc(int index) {
    deleteItem(index);
    saveStorageNote();
  }

  void deleteAllItemFunc() {
    clearAllList();
    saveStorageNote();
  }

  void deleteSelectItemFunc() {
    noteList.removeWhere((element) => element.isComplete);
    saveStorageNote();
  }
}

class ColorMap extends InputDataNote {
  final MaterialColor prymaryColor = Colors.amber;
  final Color textColor = Colors.black;
  final Color buttonColor = Colors.white;
  final Color buttonBackColor = Colors.red;
}

class MainController extends ColorMap {
  @override
  void onInit() {
    initStorageNote();
    super.onInit();
  }
}
