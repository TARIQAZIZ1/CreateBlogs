class UserModel {
  String uid = '';
  String name = '';
  String email = '';
  String password = '';
  UserModel(
      {required this.email, required this.name, required this.uid, required this.password,});

  factory UserModel.fromMap(map){
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      password: map['password'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'password': password,
      'name': name,
    };
  }
}