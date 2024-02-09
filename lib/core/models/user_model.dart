// model que será persistida no Firebase com os dados do user importantes para
// a aplicação.
class UserModel {
  String id;
  String name;
  String email;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? isActive;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });
}
