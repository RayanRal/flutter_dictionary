import 'package:dict_proj/src/db/dict_word.dart';
import 'package:flutter/material.dart';

import '../db/db.dart';
import 'bottom_bar.dart';

class AddWordScreen extends StatefulWidget {
  const AddWordScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AddWordScreenState();
}

class _AddWordScreenState extends State<AddWordScreen> {
  final TextEditingController _textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    DbManager.initDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add word'),
      ),
      bottomNavigationBar: BottomBar.buildBottomAppBar(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _textFieldController,
                decoration: const InputDecoration(
                  hintText: 'Enter word:',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _addItem();
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }

  void _addItem() {
    String newWord = _textFieldController.text;
    DbManager.insertWord(newWord, "");
    _textFieldController.clear();
  }
}
