import 'package:flutter/material.dart';
import 'package:use_ai_to_detect_offensive_words/data/Note.dart';

class NewNoteScreen extends StatefulWidget {
  @override
  _NewNoteScreenState createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen> {
  Color textFieldColor = Colors.black;
  TextEditingController noteTextEditCtrl = TextEditingController();
  TextEditingController noteNameEditCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Note"),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: noteNameEditCtrl,
                style: TextStyle(color: Colors.blue, fontSize: 18),
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: noteTextEditCtrl,
                style: TextStyle(color: textFieldColor, fontSize: 18),
                maxLines: 8,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                  onPressed: () {
                    String name = noteNameEditCtrl.text;
                    String text = noteTextEditCtrl.text;
                    print("Name $name, Text $text");
                    var note = Note(null, name, text, false);
                  },
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Save",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
