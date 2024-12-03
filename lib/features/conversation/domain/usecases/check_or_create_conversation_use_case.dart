import 'package:tunitalk/features/conversation/domain/entities/conversation_entity.dart';
import 'package:tunitalk/features/conversation/domain/repositories/conversations_repository.dart';

class CheckOrCreateConversationUseCase {
  final ConversationRepository conversationsRepository;

  CheckOrCreateConversationUseCase({required this.conversationsRepository});

  Future<String> call({required String contactId}) async {
    return conversationsRepository.checkOrCreateConversation(contactId: contactId);
  }

}