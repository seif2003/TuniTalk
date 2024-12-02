import 'package:tunitalk/features/auth/domain/entities/user_entity.dart';
import 'package:tunitalk/features/auth/domain/repositories/auth_repo.dart';

class RegisterUseCase {

  final AuthRepository repository;

  RegisterUseCase ({required this.repository});

  Future<UserEntity> call (String username,String email , String password){
    return repository.register(username,email,password);
  }
}