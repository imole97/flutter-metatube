import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:metatube/utils/snackbar_utils.dart';

class FileService {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController tagsController = TextEditingController();

  bool fieldsNotEmpty = false;
  File? _selectedFile;
  String _selectedDirectory = '';

  void saveContent(context) async {
    final title = titleController.text;
    final description = descriptionController.text;
    final tags = tagsController.text;
    final textContent =
        "Title:\n\n$title\n\nDescription:\n\n$description\n\nTags:\n\n$tags";

    try {
      if (_selectedFile != null) {
        await _selectedFile!.writeAsString(textContent); //when file is selected
      } else {
        final todayDate = getTodayDate();
        String metaDataDirPath = _selectedDirectory;
        if (metaDataDirPath.isEmpty) {
          final directory = await FilePicker.platform
              .getDirectoryPath(); // if selecteddir is empty we want to prompt the user to pick a file and gran the directory path
          if (directory == null) {
            SnackBarUtils.showSnackbar(
                context, Icons.warning, 'No directory selected');
            return; // Exit the function to prevent errors
          }
          _selectedDirectory =
              metaDataDirPath = directory; // this evaluates from righ to left
        }
        final filePath = '$metaDataDirPath/$todayDate - $title - Metadata.txt';
        final newFile = File(filePath);
        await newFile.writeAsString(textContent);
      }
      SnackBarUtils.showSnackbar(
          context, Icons.check_circle, 'File saved successfully');
    } catch (e) {
      print(e);
      SnackBarUtils.showSnackbar(context, Icons.error, 'Filed not saved');
    }
  }

  void loadFile(context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        File file = File(result.files.single.path!);
        _selectedFile = file;
        final fileContent = await file.readAsString();
        final lines = fileContent.split('\n\n');
        titleController.text = lines[1];
        descriptionController.text = lines[3];
        tagsController.text = lines[5];
        SnackBarUtils.showSnackbar(context, Icons.upload_file, 'File uploaded');
      } else {
        SnackBarUtils.showSnackbar(
            context, Icons.error_rounded, 'No file selected');
      }
    } catch (e) {
      SnackBarUtils.showSnackbar(
          context, Icons.error_rounded, 'No file selected');
    }
  }

  void newFile(context) {
    _selectedFile = null;
    titleController.clear();
    descriptionController.clear();
    tagsController.clear();
    SnackBarUtils.showSnackbar(context, Icons.file_upload, 'New file created');
  }

  static String getTodayDate() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd');
    final formattedDate = formatter.format(now);
    return formattedDate;
  }
}
