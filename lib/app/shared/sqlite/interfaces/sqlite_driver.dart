abstract class ISqliteDriver {
  Future<int> insert(String table, Map<String, Object?> values);
  Future<int> update(String table, Map<String, Object?> values, {String? where});
  Future<bool> delete(String table, {String? where});
  Future<List<Map<String, Object?>>> select(String table, {
    bool? distinct,
    List<String>? columns,
    String? where,
    List<Object?>? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
    int? offset,
  });
  Future<Map<String, Object?>> get(String table, {
    bool? distinct,
    List<String>? columns,
    String? where,
    List<Object?>? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy
  });
}