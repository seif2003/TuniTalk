import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunitalk/chat_page.dart';
import 'package:tunitalk/core/theme.dart';
import 'package:tunitalk/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:tunitalk/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tunitalk/features/auth/domain/usecases/login_use_case.dart';
import 'package:tunitalk/features/auth/domain/usecases/register_use_case.dart';
import 'package:tunitalk/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tunitalk/features/auth/presentation/pages/login_page.dart';
import 'package:tunitalk/features/auth/presentation/pages/register_page.dart';
import 'package:tunitalk/features/conversation/data/datasource/conversations_remote_data_source.dart';
import 'package:tunitalk/features/conversation/data/repositories/conversations_repository_impl.dart';
import 'package:tunitalk/features/conversation/domain/usecases/fetch_conversations_use_case.dart';
import 'package:tunitalk/features/conversation/presentation/bloc/conversations_bloc.dart';
import 'package:tunitalk/features/conversation/presentation/pages/conversations_page.dart';

void main() {

  final authRepository = AuthRepositoryImpl(authRemoteDataSource: AuthRemoteDataSource());
  final conversationsRepository = ConversationsRepositoryImpl(conversationRemoteDataSource: ConversationsRemoteDataSource());
  runApp(MyApp(authRepository: authRepository, conversationsRepository: conversationsRepository,));
}

class MyApp extends StatelessWidget {
  final AuthRepositoryImpl authRepository;
  final ConversationsRepositoryImpl conversationsRepository;

  const MyApp({super.key, required this.authRepository, required this.conversationsRepository});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => AuthBloc(
              registerUseCase: RegisterUseCase(repository: authRepository),
                loginUseCase: LoginUseCase(repository: authRepository)
            )
        ),
        BlocProvider(
            create: (_) => ConversationsBloc(
              fetchConversationsUseCase: FetchConversationsUseCase(conversationsRepository)
            )
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        home: RegisterPage(),
        routes: {
          '/login': (_) => LoginPage(),
          '/register' : (_) =>RegisterPage(),
          '/chatPage' : (_) =>ChatPage(),
          '/conversationPage': (_) => ConversationsPage()
        },
      ),
    );
  }
}
