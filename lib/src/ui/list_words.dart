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
  @override
  void initState() {
    super.initState();
    DbManager.initDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Words'),
      ),
      bottomNavigationBar: BottomBar.buildBottomAppBar(context),
      body: FutureBuilder(
        future: DbManager.getWords(),
        builder: (context, AsyncSnapshot<List<DictWord>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('SnapshotError: ${snapshot.error}'));
          } else {
            final words = snapshot.data;
            return ListView.builder(
              itemCount: words!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(words[index].original),
                  subtitle: Text(words[index].translation),
                  onLongPress: () {
                    ModifyWordDialog.showModify(context, words[index]);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
