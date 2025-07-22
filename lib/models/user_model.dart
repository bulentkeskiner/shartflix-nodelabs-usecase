class UserModel {
  String? id;
  String? name;
  String? email;
  String? photoUrl;
  String? token;

  UserModel({this.id, this.name, this.email, this.photoUrl, this.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      photoUrl: json['photoUrl'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email, 'photoUrl': photoUrl, 'token': token};
  }
}
