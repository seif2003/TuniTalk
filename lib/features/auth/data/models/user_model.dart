import 'package:tunitalk/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel ({
    required String id,
    required String username,
    required String email,
    String token = '',

}): super (id: id, username: username , email: email,token: token);

  factory UserModel.fromJson (Map<String , dynamic> json){
    return UserModel(
        id: json['id'],
        username: json['username'],
        email: json['email'],
        token: json['token']?? '',
    );
  }
}