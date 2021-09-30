class TableModel {
  final String name;
  final List<String> fields;

  TableModel(this.name, {this.fields = const <String>[]});
}