import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/functions/functions.dart';
import '../interfaces/connectivity_interface.dart';

part 'connectivity_driver.g.dart';

// We disable the singleton so the class will be instanciated
// every time the Modular.get is called
@Injectable(singleton: false)
class ConnectivityDriver implements IConnectivityDriver {
  @override
  Future<bool> get isOnline async => hasConnection();
}
