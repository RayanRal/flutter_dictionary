import 'package:dict_proj/src/db/dict_word.dart';
import 'package:flutter/material.dart';

import '../db/db.dart';

class ModifyWordDialog {
  static void showAddNew(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _buildDialog(context, _addItem, null);
      },
    );
  }

  static void showModify(
    BuildContext context,
    DictWord wordData,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _buildDialog(context, _modifyItem, wordData);
      },
    );
  }

  static Widget getModifyWindow(
    BuildContext context,
    DictWord wordData,
  ) {
    return _buildDialog(context, _modifyItem, wordData);
  }

  static Widget getAddWindow(
      BuildContext context,
      ) {
    return _buildDialog(context, _addItem, null);
  }

    static void _addItem(String word, String translation) {
    DbManager.insertWord(word, translation);
  }

  static void _modifyItem(String word, String translation) {
    DbManager.updateWord(word, translation);
  }

  static Widget _buildDialog(
      BuildContext context,
      void Function(String word, String translation) onAccept,
      DictWord? existingWord) {
    final TextEditingController _originalTextFieldController =
        TextEditingController();
    final TextEditingController _translationFieldController =
        TextEditingController();
    if (existingWord != null) {
      _originalTextFieldController.text = existingWord.original;
      _translationFieldController.text = existingWord.translation;
    }

    return AlertDialog(
      title: Text('Add / Modify Word'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _originalTextFieldController,
            decoration: InputDecoration(labelText: 'Word:'),
          ),
          TextField(
            controller: _translationFieldController,
            decoration: InputDecoration(labelText: 'Translation:'),
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            onAccept(_originalTextFieldController.text,
                _translationFieldController.text);
            Navigator.pop(context); // Close the dialog
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
