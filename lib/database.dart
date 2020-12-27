import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'data/note_dao.dart';
import 'data/Note.dart';

@Database(version: 1, entities: [
  Note,
])
abstract class AppDatabase extends FloorDatabase {
  NoteDao get noteDao;
}
