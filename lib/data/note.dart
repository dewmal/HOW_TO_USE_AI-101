class Note {
  final String name;
  final String text;
  final int status; // 1 for offensive text 0 for non offsensive text

  Note(this.name, this.text, {this.status = 0});
}
