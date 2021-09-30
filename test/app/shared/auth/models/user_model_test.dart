@Tags(['models'])

import 'dart:convert';
import 'dart:math';

import 'package:mais_filmes/app/shared/auth/interfaces/user.dart';
import 'package:mais_filmes/app/shared/auth/models/user_model.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final Faker faker = Faker();
  final Map<String,dynamic> expectedMap = {'id': Random().nextInt(100).toString(),
    'name': faker.person.name(), 'email': faker.internet.email()
  };
  final expectedUserModel = UserModel(id: expectedMap['id'],
    name: expectedMap['name'], email: expectedMap['email']
  );

  group("UserModel:", () {
    test("UserModel deveria ser herdeira da entidade User", () async {
      /// Assert
      expect(expectedUserModel, isA<User>());
    });

    test("Deveria retornar um model válido para uma única localização", () async {
      /// Act
      final result = UserModel.fromJson(json.encode(expectedMap));
      /// Assert
      expect(result, isA<User>());
    });
    test("Deveria verificar se o retorno é um Json", () async {
      /// Act
      final resultJson = expectedUserModel.toJson();
      final resultMap = expectedUserModel.toMap();
      /// Assert
      expect(resultMap, expectedMap);
      expect(resultJson, json.encode(expectedMap));
    });
  });
}
