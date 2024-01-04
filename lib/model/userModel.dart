class User {
  String name;
  String email;
  String? password;
  User({this.password, required this.email, required this.name});

  factory User.fromJson(Map<String, dynamic> json) => User(
      password: json['password'], name: json['name'], email: json['email']);
  Map<String, dynamic> toJson() =>
      {"email": email, "password": password, "name": name};
}
