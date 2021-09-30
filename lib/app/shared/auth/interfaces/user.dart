abstract class User {
  String id;
  String name;
  String email;

  User({
    required this.id,
    required this.name,
    required this.email
  });

  String? image;
  Map<String,dynamic> toMap();
}
