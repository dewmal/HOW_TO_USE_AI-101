import 'package:flutter/material.dart';

class NewNoteScreen extends StatefulWidget {
  @override
  _NewNoteScreenState createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen> {
  Color textFieldColor = Colors.black;

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
                style: TextStyle(color: textFieldColor, fontSize: 18),
                maxLines: 12,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                  onPressed: () {},
                  color: Colors.blue,
                  child: Text(
                    "Save",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
