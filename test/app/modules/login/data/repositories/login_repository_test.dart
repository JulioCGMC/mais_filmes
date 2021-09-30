
@Tags(['repositories'])

import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mais_filmes/app/core/errors/errors.dart';
import 'package:mais_filmes/app/modules/login/data/repositories/login_repository.dart';
import 'package:mais_filmes/app/modules/login/data/sources/login_data_source.dart';
import 'package:mais_filmes/app/shared/auth/models/user_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_repository_test.mocks.dart';

@GenerateMocks([ILoginDataSource])
void main() {
  final Faker faker = Faker();
  late final Map<String,dynamic> userData = {
    'id': Random().nextInt(100).toString(),
    'name': faker.person.name(),
    'email': faker.internet.email()
  };
  late final LoginRepository repository;
  late final ILoginDataSource mockDataSource;

  setUpAll(() {
    mockDataSource = MockILoginDataSource();
    repository = LoginRepository(mockDataSource);
  });

  group("Testes de sucesso:", () {
    test("Deveria logar e retornar o usuário", () async {
      // Arrange
        var user = UserModel(id: userData['id'], name: userData['name'], 
          email: userData['email']);
        when(mockDataSource.login(userData['email'],
          userData['name'])).thenAnswer((_) async => userData);
      // Act
        var response = await repository.loginEmail(email: userData['email'],
          name: userData['name']);
      // Assert
        verify(mockDataSource.login(userData['email'],
          userData['name']));
        expect(response, isA<Right>());
        expect(response.fold(id, id), equals(user));
    });

    test("Deveria cadastrar o usuário", () async {
      // Arrange
        var user = UserModel(id: userData['id'], name: userData['name'], 
          email: userData['email']);
        when(mockDataSource.signup(userData['email'],
          userData['name'])).thenAnswer((_) async => userData);
      // Act
        var response = await repository.signup(userData);
      // Assert
        verify(mockDataSource.signup(userData['email'],
          userData['name']));
        expect(response, isA<Right>());
        expect(response.fold(id, id), equals(user));
    });
  });

  group("Testes de falha:", () {
    test("Deveria tentar logar e falhar", () async {
      // Arrange
        when(mockDataSource.login(userData['email'],
          userData['name'])).thenThrow(Exception());
      // Act
        var response = await repository.loginEmail(email: userData['email'],
          name: userData['name']);
      // Assert
        verify(mockDataSource.login(userData['email'],
          userData['name']));
        expect(response, isA<Left>());
        expect(response.fold(id, id), isA<Failure>());
    });

    test("Deveria tentar cadastrar e falhar", () async {
      // Arrange
        var user = UserModel(id: userData['id'], name: userData['name'], 
          email: userData['email']);
        when(mockDataSource.signup(userData['email'],
          userData['name'])).thenThrow(Exception());
      // Act
        var response = await repository.signup(userData);
      // Assert
        verify(mockDataSource.signup(userData['email'],
          userData['name']));
        expect(response, isA<Left>());
        expect(response.fold(id, id), isA<Failure>());
    });
  });
}