
import '../../shared/sqlite/models/table_model.dart';

List<TableModel> tables = [
  TableModel('user', fields: [
    'id INTEGER PRIMARY KEY AUTOINCREMENT',
    'name TEXT',
    'email TEXT',
  ]),
  TableModel('favorite', fields: [
    'id INTEGER',
    'name TEXT',
    'email TEXT',
    'poster_path TEXT',
    'backdrop_path TEXT',
    'release_date TEXT',
    'title TEXT',
    'vote_average TEXT',
    'overview TEXT',
    'user_id INTEGER'
  ]),
];