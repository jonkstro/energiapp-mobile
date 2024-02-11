// model que será persistida no Firebase com os dados do user importantes para
// a aplicação.

class UserModel {
  String id;
  String name;
  String email;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? expiresAt;
  bool? isActive;
  String? permissao;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.createdAt,
    this.updatedAt,
    this.expiresAt,
    this.isActive,
    this.permissao,
  });
}
