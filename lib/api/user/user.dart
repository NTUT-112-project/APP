class User{
  final String uid;
  final String email;
  final String password;
  String? apiToken;

  User(this.uid, this.email, this.password);

  factory User.fromJson(dynamic json){
    return User(
        json['uid'] as String,
        json['email'] as String,
        json['password'] as String,
    );
  }
  Map toJson(){
    return {
      'uid' : uid,
      'email' : email,
      'password' : password,
    };
  }
  @override
  String toString() {
    return '{ $uid, $email,$password }';
  }
}