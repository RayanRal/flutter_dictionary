import 'package:dict_proj/src/ui/add_word.dart';
import 'package:dict_proj/src/ui/list_words.dart';
import 'package:flutter/material.dart';

class BottomBar {
  static BottomAppBar buildBottomAppBar(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              // Navigate to the ListWordsScreen when the info button is pressed
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListWordsScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddWordScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.play_arrow),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
