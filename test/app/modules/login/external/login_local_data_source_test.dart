@Tags(['data_sources'])

import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mais_filmes/app/modules/login/external/login_local_data_source.dart';
import 'package:mais_filmes/app/shared/sqlite/interfaces/sqlite_driver.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_local_data_source_test.mocks.dart';

@GenerateMocks([ISqliteDriver])
void main() {
  final Faker faker = Faker();
  late final Map<String, Object?> userData = {
    'name': faker.person.name(),
    'email': faker.internet.email()
  };
  late final LoginLocalDataSource dataSource;
  late final ISqliteDriver mockDriver;

  setUpAll(() {
    mockDriver = MockISqliteDriver();
    dataSource = LoginLocalDataSource(mockDriver);
  });

  group("Testes de sucesso:", () {
    test("Deveria logar e retornar o usuário", () async {
      // Arrange
        when(mockDriver.get(dataSource.userTable, where: anyNamed('where'), 
          whereArgs: anyNamed('whereArgs'))).thenAnswer((_) async => userData);
      // Act
        var response = await dataSource.login(userData['email'] as String,
          userData['name'] as String);
      // Assert
        verify(mockDriver.get(dataSource.userTable, where: anyNamed('where'), 
          whereArgs: anyNamed('whereArgs')));
        expect(response, equals(userData));
    });

    test("Deveria cadastrar o usuário", () async {
      // Arrange
        var expectedResponse = userData;
        expectedResponse['id'] = Random().nextInt(100);
        when(mockDriver.insert(dataSource.userTable, {'email': userData['email'],
          'name': userData['name']})).thenAnswer((_) async 
            => expectedResponse['id'] as int);
      // Act
        var response = await dataSource.signup(userData['email'] as String,
          userData['name'] as String);
      // Assert
        verify(mockDriver.insert(dataSource.userTable, userData));
        expect(response, equals(expectedResponse));
    });
  });

  group("Testes de falha:", () {
    test("Deveria tentar logar e falhar", () async {
      // Arrange
        when(mockDriver.get(dataSource.userTable, where: anyNamed('where'), 
          whereArgs: anyNamed('whereArgs'))).thenThrow(Exception());
      // Assert
        expect(() async => await dataSource.login(userData['email'] as String,
          userData['name'] as String), throwsException);
    });

    test("Deveria tentar cadastrar e falhar", () async {
      // Arrange
        var expectedResponse = userData;
        expectedResponse['id'] = Random().nextInt(100);
        when(mockDriver.insert(dataSource.userTable, {'email': userData['email'],
          'name': userData['name']})).thenThrow(Exception());
      // Assert
        expect(() async => await  dataSource.signup(userData['email'] as String,
          userData['name'] as String), throwsException);
    });
  });
}