import 'package:tunitalk/features/conversation/data/datasource/conversations_remote_data_source.dart';
import 'package:tunitalk/features/conversation/domain/entities/conversation_entity.dart';
import 'package:tunitalk/features/conversation/domain/repositories/conversations_repository.dart';

class ConversationsRepositoryImpl implements ConversationRepository {
  final ConversationsRemoteDataSource conversationRemoteDataSource;

  ConversationsRepositoryImpl({required this.conversationRemoteDataSource});

  @override
  Future<List<ConversationEntity>> fetchConversation() async {
    return await conversationRemoteDataSource.fetchConversations();
  }

  @override
  Future<String> checkOrCreateConversation({required String contactId}) async {
    return await conversationRemoteDataSource.checkOrCreateConversation(contactId:contactId);
  }

}