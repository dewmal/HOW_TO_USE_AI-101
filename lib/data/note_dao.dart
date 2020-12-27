import 'package:floor/floor.dart';

import 'Note.dart';

@dao
abstract class NoteDao {
  @insert
  Future<void> insertNote(Note note);
}
