import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Tokenizer {
  int count;
  String path;

  Tokenizer(this.count, this.path);

  Future<List<double>> getTokenized(String input) async {
    Map<String, dynamic> data = await rootBundle
        .loadString(path)
        .then((value) => jsonDecode(value)); // load json data and decode value
    var each_word = input.split(" "); // take each word from user input string
    var wordtovec = [];
    List<double> bagofwords = new List(count);

    for (var e in each_word) {
      if (data[e] != null) wordtovec.add(data[e]);
    }

    // if elements of wordtovec is in json file add a '1' at that  position else '0'
    for (var i = 0; i < count; i++) {
      if (wordtovec.contains(i))
        bagofwords[i] = 1;
      else
        bagofwords[i] = 0;
    }
    // return matrix
    return bagofwords;
  }
}
