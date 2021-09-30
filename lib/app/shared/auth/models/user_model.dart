import 'dart:convert';

import 'package:mais_filmes/app/core/constants/apis.dart';
import 'package:mais_filmes/app/core/functions/functions.dart';

import '../interfaces/user.dart';

class UserModel extends User {
  UserModel({
    required String id,
    required String name,
    required String email
  }) : super(id: id, name: name, email: email);
  
  String get image => "${Apis.baseGravatarUrl}/${createEmailHash(email)}";

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'].toString(),
      name: map['name'],
      email: map['email']
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.id == id &&
      other.name == name &&
      other.email == email;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      email.hashCode;
  }
}
