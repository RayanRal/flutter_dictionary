import 'package:dict_proj/src/db/db.dart';
import 'package:dict_proj/src/db/dict_word.dart';
import 'package:dict_proj/src/ui/word_popup.dart';
import 'package:flutter/material.dart';

import 'bottom_bar.dart';

class ListWordsScreen extends StatefulWidget {
  const ListWordsScreen({super.key});

  @override
  State<ListWordsScreen> createState() => _ListWordsScreenState();
}

class _ListWordsScreenState extends State<ListWordsScreen> {
  List<DictWord> wordsList = [];

  @override
  void initState() {
    super.initState();
    DbManager.initDb();
    _loadWords();
  }

  Future<void> _loadWords() async {
    final words = await DbManager.getWords();
    setState(() {
      wordsList = words;
    });
  }

  void _handleLongPress(DictWord word) async {
    await showDialog(
        context: context,
        builder: (context) => ModifyWordDialog.getModifyWindow(context, word));
    await _loadWords(); // Reload words after modification
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Words'),
      ),
      bottomNavigationBar: BottomBar.buildBottomAppBar(context),
      body: ListView.builder(
        itemCount: wordsList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(wordsList[index].original),
            subtitle: Text(wordsList[index].translation),
            onLongPress: () {
              _handleLongPress(wordsList[index]);
            },
          );
        },
      ),
    );
  }
}
