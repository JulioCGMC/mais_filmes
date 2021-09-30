import 'dart:async';
import 'dart:io';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/constants/metadata.dart';
import '../interfaces/local_storage_driver.dart';

part 'local_storage_hive_driver.g.dart';

@Injectable()
class LocalStorageHiveDriver extends Disposable implements ILocalStorageDriver {

  final Completer<Box> _instance = Completer<Box>();
  late final String boxName;

  LocalStorageHiveDriver([bool testMode = false]) {
    boxName = "hive_${Metadata.appName.replaceAll(' ', '_').toLowerCase()}";
    _init(testMode);
  }

  _init([bool testMode = false]) async {
    if (!testMode) {
      Directory directory = await getApplicationDocumentsDirectory();
      Hive.init(directory.path);
    }
    Box db = await Hive.openBox(boxName);
    _instance.complete(db);
  }

  @override
  Future<void> delete(String key) async {
    Box box = await _instance.future;
    box.delete(key);
  }

  @override
  Future<dynamic> get(String key) async {
    Box box = await _instance.future;
    return box.get(key);
  }

  @override
  Future<void> put(String key, dynamic value) async {
    Box box = await _instance.future;
    box.put(key, value);
  }

  @override
  void dispose() {
    Hive.box(boxName).compact();
    Hive.close();
  }
  
}
