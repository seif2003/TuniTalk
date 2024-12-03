import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunitalk/core/socket_service.dart';
import 'package:tunitalk/features/chat/data/datasources/message_remote_data_source.dart';
import 'package:tunitalk/features/chat/data/repositories/message_repository_impl.dart';
import 'package:tunitalk/features/chat/domain/usecases/fetch_messages_use_case.dart';
import 'package:tunitalk/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:tunitalk/features/chat/presentation/pages/chat_page.dart';
import 'package:tunitalk/core/theme.dart';
import 'package:tunitalk/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:tunitalk/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tunitalk/features/auth/domain/usecases/login_use_case.dart';
import 'package:tunitalk/features/auth/domain/usecases/register_use_case.dart';
import 'package:tunitalk/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tunitalk/features/auth/presentation/pages/login_page.dart';
import 'package:tunitalk/features/auth/presentation/pages/register_page.dart';
import 'package:tunitalk/features/contact/data/datasources/contacts_remote_data_source.dart';
import 'package:tunitalk/features/contact/data/repositories/contacts_repository_impl.dart';
import 'package:tunitalk/features/contact/domain/usecases/add_contact_usecase.dart';
import 'package:tunitalk/features/contact/domain/usecases/fetch_contacts_usecase.dart';
import 'package:tunitalk/features/contact/presentation/bloc/contacts_bloc.dart';
import 'package:tunitalk/features/conversation/data/datasource/conversations_remote_data_source.dart';
import 'package:tunitalk/features/conversation/data/repositories/conversations_repository_impl.dart';
import 'package:tunitalk/features/conversation/domain/usecases/check_or_create_conversation_use_case.dart';
import 'package:tunitalk/features/conversation/domain/usecases/fetch_conversations_use_case.dart';
import 'package:tunitalk/features/conversation/presentation/bloc/conversations_bloc.dart';
import 'package:tunitalk/features/conversation/presentation/pages/conversations_page.dart';

void main() async{
  final socketService = SocketService();
  await socketService.initSocket();

  final authRepository = AuthRepositoryImpl(authRemoteDataSource: AuthRemoteDataSource());
  final conversationsRepository = ConversationsRepositoryImpl(conversationRemoteDataSource: ConversationsRemoteDataSource());
  final messagesRepository = MessageRepositoryImpl(remoteDataSource: MessageRemoteDataSource());
  final contactsRepository = ContactsRepositoryImpl(remoteDataSource: ContactsRemoteDataSource());

  runApp(
      MyApp(
        authRepository: authRepository,
        conversationsRepository: conversationsRepository,
        messagesRepository: messagesRepository,
        contactsRepository: contactsRepository
      )
  );
}

class MyApp extends StatelessWidget {
  final AuthRepositoryImpl authRepository;
  final ConversationsRepositoryImpl conversationsRepository;
  final MessageRepositoryImpl messagesRepository;
  final ContactsRepositoryImpl contactsRepository;

  const MyApp({super.key,
    required this.authRepository,
    required this.conversationsRepository,
    required this.messagesRepository,
    required this.contactsRepository,
  });

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
        ),
        BlocProvider(
            create: (_) => ChatBloc(
              fetchMessageUseCase: FetchMessageUseCase(messageRepository: messagesRepository)
            )
        ),
        BlocProvider(
            create: (_) => ContactsBloc(
              fetchContactUseCase: FetchContactUseCase(contactsRepository: contactsRepository),
              addContactUseCase: AddContactUseCase(contactsRepository: contactsRepository),
              checkOrCreateConversationUseCase: CheckOrCreateConversationUseCase(conversationsRepository: conversationsRepository)
            )
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
        routes: {
          '/login': (_) => LoginPage(),
          '/register' : (_) =>RegisterPage(),
          '/conversationPage': (_) => ConversationsPage()
        },
      ),
    );
  }
}
