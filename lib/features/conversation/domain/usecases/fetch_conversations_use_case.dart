import 'package:tunitalk/features/conversation/domain/entities/conversation_entity.dart';
import 'package:tunitalk/features/conversation/domain/repositories/conversations_repository.dart';

class FetchConversationsUseCase {
  final ConversationRepository repository;

  FetchConversationsUseCase(this.repository);

  Future<List<ConversationEntity>> call() async {
    return repository.fetchConversation();
  }
}