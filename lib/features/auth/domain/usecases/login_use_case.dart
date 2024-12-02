import 'package:tunitalk/features/auth/domain/entities/user_entity.dart';
import 'package:tunitalk/features/auth/domain/repositories/auth_repo.dart';

class LoginUseCase {

  final AuthRepository repository;

  LoginUseCase ({required this.repository});

  Future<UserEntity> call (String email , String password){
    return repository.login(email,password);
  }
}