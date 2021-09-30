import 'package:mais_filmes/app/shared/network/drivers/connectivity_driver.dart';
import 'package:mais_filmes/app/shared/network/interfaces/connectivity_interface.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final IConnectivityDriver connectivityDriver = ConnectivityDriver();

  test("Deveria estar conectado", () async {
    /// Assert
    expect(await connectivityDriver.isOnline, isA<bool>());
  });
}
