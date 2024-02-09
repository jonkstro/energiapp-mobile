// model que será persistida no Firebase com os dados do user importantes para
// a aplicação.
class UserModel {
  String id;
  String name;
  String email;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.createdAt,
    this.updatedAt,
  });
}
