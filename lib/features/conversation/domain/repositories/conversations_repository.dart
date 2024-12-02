import 'package:tunitalk/features/conversation/domain/entities/conversation_entity.dart';

abstract class ConversationRepository {
  Future<List<ConversationEntity>> fetchConversation();
}