import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tunitalk/features/auth/domain/usecases/login_use_case.dart';
import 'package:tunitalk/features/auth/domain/usecases/register_use_case.dart';
import 'package:tunitalk/features/auth/presentation/bloc/auth_event.dart';
import 'package:tunitalk/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUseCase registerUseCase; // Correction du nom.
  final LoginUseCase loginUseCase; // Correction du nom.
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  AuthBloc({
    required this.registerUseCase,
    required this.loginUseCase,
  }) : super(AuthInitial()) {
    on<RegisterEvent>(_onRegister);
    on<LoginEvent>(_onLogin);
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await registerUseCase.call(event.username, event.email, event.password);
      emit(AuthSuccess(message: "Registration successful"));
    } catch (e) {
      emit(AuthFailure(error: 'Registration failed')); // Correction orthographique.
    }
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await loginUseCase.call(event.email, event.password);
      await _storage.write(key: 'token', value: user.token);
      print(user.token);// Correction pour accéder à `user.token`.
      emit(AuthSuccess(message: "Login successful")); // Correction du message.
    } catch (e) {
      //emit(AuthFailure(error: 'Login failed')); // Correction orthographique.
      print('Login Error: $e'); // Log the actual error
      emit(AuthFailure(error: e.toString())); // More detailed error
    }
  }
}
