class UserModel {
  final String? id;
  final String? profileImage;
  final String name;
  final DateTime birthday;
  final String email;
  final String password;
  final String gender;
  final String number;

  UserModel({
    this.id,
    this.profileImage,
    required this.name,
    required this.birthday,
    required this.email,
    required this.password,
    required this.gender,
    required this.number,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'],
      profileImage: map['profileImage'],
      name: map['name'],
      birthday: DateTime.parse(map['birthday']),
      email: map['email'],
      password: map['password'],
      gender: map['gender'],
      number: map['number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'profileImage': profileImage,
      'name': name,
      'birthday': birthday.toIso8601String(),
      'email': email,
      'password': password,
      'gender': gender,
      'number': number,
    };
  }
}
