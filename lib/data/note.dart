import 'package:floor/floor.dart';

@entity
class Note {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String name;
  final String text;
  final bool isOffensive; // 1 for offensive text 0 for non offsensive text

  Note(this.id, this.name, this.text, this.isOffensive);
}
