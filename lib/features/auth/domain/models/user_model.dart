class UserModel {

  const UserModel({
    required this.email,
    this.name,
    this.password,
    this.token,
  });
  final String email;
  final String? password;
  final String? token;
  final String? name;

  
  Map<String, dynamic> toJson() {
    return <String, dynamic> {
      'username': email,
      'password': password,
      'firstName': name,
    };
  }
  
  
  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'].toString(),
      password: json['password'].toString(),
      token: json['token'].toString(),
      name: json['name'].toString()
    );
  }

  UserModel copyWith({
    String? email,
    String? password,
    String? token,
    String? name,
  }) {
    return UserModel(
      email: email ?? this.email,
      password: password ?? this.password,
      token: token ?? this.token,
      name: name ?? this.name,
    );
  }

}
