@Tags(['drivers'])

import 'package:mais_filmes/app/shared/local_storage/drivers/local_storage_hive_driver.dart';
import 'package:mais_filmes/app/shared/local_storage/interfaces/local_storage_driver.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_test/hive_test.dart';

void main() {
  late final ILocalStorageDriver localStorageDriver;
  final Faker faker = Faker();

  setUpAll(() async {
    await setUpTestHive();
    localStorageDriver = LocalStorageHiveDriver(true);
  });

  tearDownAll(() async {
    await tearDownTestHive();
  });

  group("Local Storage:", () {
    test("Deveria inserir um String, e verificar se ele foi armazenado e deletado.", () async {
      // Arrange
        final String expectedValue = faker.randomGenerator.string(20);
      // Act
        await localStorageDriver.put("test", expectedValue);
        var result = await localStorageDriver.get("test");
        await localStorageDriver.delete("test");
        var result2 = await localStorageDriver.get("test");
      // Assert
        expect(result, equals(expectedValue));
        expect(result2, isNull);
    });

    test("Deveria inserir um int, e verificar se ele foi armazenado e deletado.", () async {
      // Arrange
        final int expectedValue = faker.randomGenerator.integer(10000);
      // Act
        await localStorageDriver.put("test", expectedValue);
        var result = await localStorageDriver.get("test");
        await localStorageDriver.delete("test");
        var result2 = await localStorageDriver.get("test");
      // Assert
        expect(result, equals(expectedValue));
        expect(result2, isNull);
    });

    test("Deveria inserir um bool, e verificar se ele foi armazenado e deletado.", () async {
      // Arrange
        final bool expectedValue = faker.randomGenerator.boolean();
      // Act
        await localStorageDriver.put("test", expectedValue);
        var result = await localStorageDriver.get("test");
        await localStorageDriver.delete("test");
        var result2 = await localStorageDriver.get("test");
      // Assert
        expect(result, equals(expectedValue));
        expect(result2, isNull);
    });

    test("Deveria inserir um List, e verificar se ele foi armazenado e deletado.", () async {
      // Arrange
        final List expectedValue = faker.randomGenerator.numbers(10000, 100);
      // Act
        await localStorageDriver.put("test", expectedValue);
        var result = await localStorageDriver.get("test");
        await localStorageDriver.delete("test");
        var result2 = await localStorageDriver.get("test");
      // Assert
        expect(result, equals(expectedValue));
        expect(result2, isNull);
    });

    test("Deveria inserir um map, e verificar se ele foi armazenado e deletado.", () async {
      // Arrange
        final Map expectedValue = {
          'cuisine': faker.food.cuisine(),
          'dish': faker.food.dish(),
          'restaurant': faker.food.restaurant()
        };
      // Act
        await localStorageDriver.put("test", expectedValue);
        var result = await localStorageDriver.get("test");
        await localStorageDriver.delete("test");
        var result2 = await localStorageDriver.get("test");
      // Assert
        expect(result, equals(expectedValue));
        expect(result2, isNull);
    });
  });
}