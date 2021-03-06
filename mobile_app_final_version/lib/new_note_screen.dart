import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:use_ai_to_detect_offensive_words/tokenizer.dart';

class NewNoteScreen extends StatefulWidget {
  final StreamController<Map<String, dynamic>> noteCtrl;

  const NewNoteScreen({Key key, this.noteCtrl}) : super(key: key);
  @override
  _NewNoteScreenState createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen> {
  Color textFieldColor = Colors.black;
  Color offensiceTextFieldColor = Colors.red;
  TextEditingController noteTextEditCtrl = TextEditingController();
  TextEditingController noteNameEditCtrl = TextEditingController();

  bool isOffensiveText = false;

  Tokenizer tokenizer = Tokenizer(1000, "assets/devive_json.json");

  @override
  void initState() {}

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
                style: TextStyle(
                    color: isOffensiveText
                        ? offensiceTextFieldColor
                        : textFieldColor,
                    fontSize: 18),
                maxLines: 8,
                decoration: InputDecoration(border: OutlineInputBorder()),
                onChanged: (text) async {
                  _getPredictData(text);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                  onPressed: () async {
                    String nameVal = noteNameEditCtrl.text;
                    String textVal = noteTextEditCtrl.text;
                    double status = await _getPredictData(textVal);
                    print("Name $nameVal, Text $textVal");
                    final Map<String, String> row = {
                      "name": nameVal,
                      "text": textVal,
                      "status": "$status"
                    };
                    this.widget.noteCtrl.add(row);
                    Navigator.pop(context);
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

  Future<double> _getPredictData(String text) async {
    var inputs = await tokenizer.getTokenized(text);
    var output = List<double>(1).reshape([1, 1]);
    final interpreter = await Interpreter.fromAsset('offsensive_model.tflite');
    interpreter.run(inputs, output);

    print("Rate ${output[0][0]}");

    var result = "1";
    if (output[0][0] > 0.5) {
      result = "1";
    } else {
      result = "0";
    }
    setState(() {
      if (result == "1") {
        isOffensiveText = true;
      } else
        isOffensiveText = false;
    });
    return output[0][0];
  }
}
