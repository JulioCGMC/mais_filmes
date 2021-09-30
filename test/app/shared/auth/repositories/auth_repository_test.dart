@Tags(['repositories'])

import 'dart:math';

import 'package:mais_filmes/app/shared/auth/interfaces/auth_data_source.dart';
import 'package:mais_filmes/app/shared/auth/models/user_model.dart';
import 'package:mais_filmes/app/shared/auth/repositories/auth_repository.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repository_test.mocks.dart';


@GenerateMocks([IAuthDataSource])
void main() {
  final Faker faker = Faker();
  late final Map<String,dynamic> userData = {
    'id': Random().nextInt(100).toString(),
    'name': faker.person.name(),
    'email': faker.internet.email()
  };
  late final AuthRepository repository;
  late final IAuthDataSource mockDataSource;

  setUpAll(() {
    mockDataSource = MockIAuthDataSource();
    repository = AuthRepository(mockDataSource);
  });

  group("Auth Repository:", () {
    test("Deveria retornar um usuário logado", () async {
      // Arrange
        UserModel user = UserModel(id: userData['id'], 
          name: userData['name'], email: userData['email']);
        when(mockDataSource.getUser()).thenAnswer((_) async => userData);
      // Act
        var response = await repository.getUser();
      // Assert
        verify(mockDataSource.getUser());
        expect(response, isA<UserModel>());
        expect(response, equals(user));
    });

    test("Deveria retornar um null", () async {
      // Arrange
        when(mockDataSource.getUser()).thenThrow(Exception());
      // Act
        var response = await repository.getUser();
      // Assert
        expect(response, isNull);
    });
  });
}