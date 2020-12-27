import 'package:flutter/material.dart';
import 'package:use_ai_to_detect_offensive_words/new_note_screen.dart';
import 'package:sqlcool/sqlcool.dart';

Db db = Db();
// define the database schema
DbTable note = DbTable("note")
  ..varchar("name", unique: true)
  ..text("text", nullable: false)
  ..real("status", defaultValue: 1)
  ..index("name");
List<DbTable> schema = [note];

void main() {
  runApp(MyApp());
  String dbpath = "db.sqlite"; // relative to the documents directory
  try {
    db
        .init(path: dbpath, schema: schema)
        .then((value) => print("database init...."));
  } catch (e) {
    rethrow;
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Note Book'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: StreamBuilder<List<Map<String, dynamic>>>(
            stream: getNoteList(),
            builder: (context, snapshot) {
              if (snapshot.error != null || snapshot.data == null)
                return Container(
                  child: Text("Empty"),
                );
              print(snapshot.data);
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ...snapshot.data
                      .map((data) => Padding(
                            padding: EdgeInsets.only(bottom: 12.0),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: double.parse("${data['status']}") > 0.6
                                      ? Colors.amber
                                      : Colors.red),
                              child: Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${data['name']}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                      Text(
                                        '${data['text']}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                      Text(
                                        '${data['status']}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      )
                                    ],
                                  )),
                            ),
                          ))
                      .toList()
                ],
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewNoteScreen(
                      db: db,
                    )),
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.note_add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Stream<List<Map<String, dynamic>>> getNoteList() async* {
    var data = await db.select(
      table: "note",
      limit: 20,
      columns: "name,text,status",
    );
    yield data;
  }
}
